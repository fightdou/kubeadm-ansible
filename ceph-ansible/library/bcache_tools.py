#!/usr/bin/python

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

from ansible.module_utils.basic import AnsibleModule
import datetime
import subprocess

ANSIBLE_METADATA = {
    'metadata_version': '1.0',
    'status': ['preview'],
    'supported_by': 'community'
}

DOCUMENTATION = '''
  pass
'''

EXAMPLES = '''
  pass
'''


def exec_command(module, cmd):
    '''Execute command'''
    rc, out, err = module.run_command(cmd)
    return rc, cmd, out, err


def get_make_bcache_cache_cmds(module):
    bcache_map_list = module.params['bcache_map_list']
    cmd_list = []
    for bcache_map in bcache_map_list:
        cache_dev = bcache_map.get('cache')
        cmd = ' make-bcache -C '
        cmd += cache_dev
        cmd += ' --wipe-bcache'
        cmd_list.append(cmd)
    return cmd_list


def get_make_bcache_backing_cmds(module):
    bcache_map_list = module.params['bcache_map_list']
    cmd_list = []
    for bcache_map in bcache_map_list:
        data_dev = bcache_map.get('data')
        cmd = ' make-bcache -B '
        cmd += data_dev
        cmd += ' --wipe-bcache'
        cmd_list.append(cmd)
    return cmd_list


def get_attach_bcache_mapping_cmds(module):
    bcache_map_list = module.params['bcache_map_list']
    cmd_list = []
    for bcache_map in bcache_map_list:
        # /dev/nvme0n1
        cache_dev = bcache_map.get('cache')
        # /dev/sda /dev/sdb
        data_dev_str = bcache_map.get('data')
        info_cache_cmd = 'bcache-super-show ' + cache_dev
        rc, out, err = module.run_command(info_cache_cmd)
        result = dict(
            cmd=info_cache_cmd,
            start='',
            end='',
            delta='',
            rc=rc,
            stdout=out.rstrip('\r\n'),
            stderr=err.rstrip('\r\n'),
            changed='',
        )
        if rc != 0:
            module.fail_json(msg='non-zero return code', **result)
        cache_uuid = out.split('\t')[-1].split('\n')[0]
        for data_dev in data_dev_str.split():
            # sda
            data_dev_name = data_dev.split('/')[-1]
            # echo uuid > /sys/block/vde/bcache/attach
            cmd_list.append('echo ' + cache_uuid +
                            '> /sys/block/' + data_dev_name +
                            '/bcache/attach')
    return cmd_list


def clean_bcache(module):
    bcache_map_list = module.params['bcache_map_list']
    stop_cmd_list = []
    wipefs_cmd_list = []
    for bcache_map in bcache_map_list:
        cache_dev = bcache_map.get('cache')
        data_dev_str = bcache_map.get('data')
        cache_dev_name = cache_dev.split('/')[-1]
        unregister_cmd = 'echo 1 > /sys/block/'
        unregister_cmd += cache_dev_name
        unregister_cmd += '/bcache/set/unregister '
        stop_cmd_list.append(unregister_cmd)
        wipefs_cmd_list.append('wipefs -a /dev/' + cache_dev_name)
        for data_dev in data_dev_str.split():
            data_dev_name = data_dev.split('/')[-1]
            stop_data_cmd = 'echo 1 > /sys/block/'
            stop_data_cmd += data_dev_name
            stop_data_cmd += '/bcache/stop'
            stop_cmd_list.append(stop_data_cmd)
            wipefs_cmd_list.append('wipefs -a /dev/' + data_dev_name)
    return stop_cmd_list + wipefs_cmd_list


def filter_disk(module):
    bcache_map_list = module.params['bcache_map_list']
    new_bcache_map_list = []
    for bcache_map in bcache_map_list:
        data_dev_str = bcache_map.get('data')
        need_make_dev = ''
        for data_dev in data_dev_str.split():
            data_dev_name = data_dev.split('/')[-1]
            rc, out, err = module.run_command('ls /sys/block/' +
                                              data_dev_name + '/bcache')
            if rc != 0:
                # bcache need make
                need_make_dev += data_dev
                need_make_dev += ' '
        if need_make_dev != '':
            # remake bcache_map_list
            bcache_map['data'] = need_make_dev
            new_bcache_map_list.append(bcache_map)
    return new_bcache_map_list


def filter_osd(module):
    bcache_map_list = module.params['bcache_map_list']
    if len(bcache_map_list) == 0:
        return bcache_map_list
    need_osd_dev = []
    for bcache_map in bcache_map_list:
        data_dev_str = bcache_map.get('data')
        for data_dev in data_dev_str.split():
            data_dev_name = data_dev.split('/')[-1]
            rc, out, err = module.run_command('ls -al /sys/block/' +
                                              data_dev_name + '/bcache/dev')
            bcache_dev_name = out.split('/')[-1].split('\n')[0]
            # bcache need make
            need_osd_dev.append(bcache_dev_name)
    return need_osd_dev


def get_bcache_param_set_cmds(module):
    bcache_map_list = module.params['bcache_map_list']
    bcache_mode = module.params['bcache_mode']
    bcache_writeback_percent = module.params['bcache_writeback_percent']
    bcache_writeback_rate_minimum = \
        module.params['bcache_writeback_rate_minimum']
    cmd_list = []
    for bcache_map in bcache_map_list:
        data_dev_str = bcache_map.get('data')
        for data_dev in data_dev_str.split():
            data_dev_name = data_dev.split('/')[-1]
            # set cache module
            cmd1 = 'echo ' + bcache_mode + ' > /sys/block/'
            cmd1 += data_dev_name
            cmd1 += '/bcache/cache_mode'
            cmd_list.append(cmd1)
            # set writeback percent
            cmd2 = 'echo ' + str(bcache_writeback_percent) + ' > /sys/block/'
            cmd2 += data_dev_name
            cmd2 += '/bcache/writeback_percent'
            cmd_list.append(cmd2)
            # set minimum writeback speed
            cmd3 = 'echo ' + str(bcache_writeback_rate_minimum) \
                   + ' > /sys/block/'
            cmd3 += data_dev_name
            cmd3 += '/bcache/writeback_rate_minimum'
            cmd_list.append(cmd3)
    return cmd_list


def subprocess_run_shell(cmd):
    out = subprocess.check_output(cmd, shell=True)
    subprocess.call("exit 1", shell=True)
    return out


def run_module():
    module_args = dict(
        bcache_map_list=dict(type='list', required=False, default=[]),
        action=dict(type='str', required=False, choices=[
            'make_cache', 'make_backing', 'attach', 'clean', 'filter_dev',
            'filter_osd', 'param_set', 'get_disks'], default='make_cache'),
        bcache_mode=dict(type='str', required=False, default='writeback'),
        bcache_writeback_percent=dict(
            type='int', required=False, default=40),
        bcache_writeback_rate_minimum=dict(
            type='int', required=False, default=2048),
    )

    module = AnsibleModule(
        argument_spec=module_args,
        supports_check_mode=True
    )

    result = dict(
        changed=False,
        stdout='',
        stderr='',
        rc='',
        start='',
        end='',
        delta='',
    )

    if module.check_mode:
        return result

    # start execution
    startd = datetime.datetime.now()

    # get the desired action
    action = module.params['action']

    # Assume the task's status will be 'changed'
    changed = True

    if action == 'make_cache':
        # make-bcache mapping
        make_bcache_cache_cmds = get_make_bcache_cache_cmds(module)
        if len(make_bcache_cache_cmds) == 0:
            module.exit_json(**dict())
        for cmd_value in make_bcache_cache_cmds:
            rc, cmd, out, err = exec_command(module, cmd_value)
            endd = datetime.datetime.now()
            delta = endd - startd
            result = dict(
                cmd=cmd,
                start=str(startd),
                end=str(endd),
                delta=str(delta),
                rc=rc,
                stdout=out.rstrip('\r\n'),
                stderr=err.rstrip('\r\n'),
                changed=changed,
            )
            if rc != 0:
                module.fail_json(msg='non-zero return code', **result)
        module.exit_json(**dict(cmd=make_bcache_cache_cmds))
    elif action == 'make_backing':
        make_bcache_backing_cmds = get_make_bcache_backing_cmds(module)
        if len(make_bcache_backing_cmds) == 0:
            module.exit_json(**dict())
        for cmd_value in make_bcache_backing_cmds:
            rc, cmd, out, err = exec_command(
                module, cmd_value)
            endd = datetime.datetime.now()
            delta = endd - startd
            result = dict(
                cmd=cmd,
                start=str(startd),
                end=str(endd),
                delta=str(delta),
                rc=rc,
                stdout=out.rstrip('\r\n'),
                stderr=err.rstrip('\r\n'),
                changed=changed,
            )
            if rc != 0:
                module.fail_json(msg='non-zero return code', **result)
        module.exit_json(**dict(cmd=make_bcache_backing_cmds))
    elif action == 'attach':
        attach_bcache_mapping_cmds = get_attach_bcache_mapping_cmds(module)
        if len(attach_bcache_mapping_cmds) == 0:
            module.exit_json()
        out_line = ''
        for cmd_value in attach_bcache_mapping_cmds:
            out = subprocess.check_output(cmd_value, shell=True)
            subprocess.call("exit 1", shell=True)
            out_line += str(out)
        # out = subprocess.check_output(attach_bcache_mapping_cmds, shell=True)
        endd = datetime.datetime.now()
        delta = endd - startd
        result = dict(
            cmd=attach_bcache_mapping_cmds,
            start=str(startd),
            end=str(endd),
            delta=str(delta),
            rc=0,
            stdout=str(out_line).rstrip('\r\n'),
            stderr=str(out_line).rstrip('\r\n'),
            changed=changed,
        )
        module.exit_json(**result)
    elif action == 'filter_dev':
        # make-bcache mapping
        new_bcache_map_list = filter_disk(module)
        endd = datetime.datetime.now()
        delta = endd - startd
        result = dict(
            cmd='',
            start=str(startd),
            end=str(endd),
            delta=str(delta),
            rc=0,
            stdout=str(new_bcache_map_list).rstrip('\r\n'),
            stderr=str(new_bcache_map_list).rstrip('\r\n'),
            changed=changed,
        )
        module.exit_json(**result)
    elif action == 'filter_osd':
        need_osd_dev = filter_osd(module)
        endd = datetime.datetime.now()
        delta = endd - startd
        result = dict(
            cmd='',
            start=str(startd),
            end=str(endd),
            delta=str(delta),
            rc=0,
            stdout=str(need_osd_dev).rstrip('\r\n'),
            stderr=str(need_osd_dev).rstrip('\r\n'),
            changed=changed,
        )
        module.exit_json(**result)
    elif action == 'clean':
        # clean make-bcache mapping
        cmd_list = clean_bcache(module)
        endd = datetime.datetime.now()
        delta = endd - startd
        result = dict(
            cmd=cmd_list,
            start=str(startd),
            end=str(endd),
            delta=str(delta),
            rc=0,
            stdout="",
            stderr="",
            changed=changed,
        )
        module.exit_json(**result)
    elif action == 'param_set':
        # bcache param_set
        bcache_param_set_cmds = get_bcache_param_set_cmds(module)
        if len(bcache_param_set_cmds) == 0:
            module.exit_json()
        out_line = ''
        for param_set_cmd_value in bcache_param_set_cmds:
            out = subprocess_run_shell(param_set_cmd_value)
            out_line += str(out)
        endd = datetime.datetime.now()
        delta = endd - startd
        result = dict(
            cmd=bcache_param_set_cmds,
            start=str(startd),
            end=str(endd),
            delta=str(delta),
            rc=0,
            stdout=str(out_line).rstrip('\r\n'),
            stderr=str(out_line).rstrip('\r\n'),
            changed=changed,
        )
        module.exit_json(**result)
    elif action == 'get_disks':
        bcache_map_list = module.params['bcache_map_list']
        disks = []
        for bcache_map in bcache_map_list:
            # /dev/sda /dev/sdb
            data_dev_str = bcache_map.get('data')
            for data_dev in data_dev_str.split():
                data_dev_name = data_dev.split('/')[-1]
                disks.append(data_dev_name)
        module.exit_json(**dict(stdout=str(disks)))
    else:
        module.fail_json(
            msg='State must either be "make".', changed=False, rc=1)


def main():
    run_module()


if __name__ == '__main__':
    main()
