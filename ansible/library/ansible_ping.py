from sys import stdout
from ansible.module_utils.basic import *
from pkg_resources import require

def build_ping_cmd(times, interval, interface, ipaddress):

    cmd = ['ping',]

    base_cmd = [
        '-c',
        times,
        '-i',
        interval,
        '-I',
        interface,
        ipaddress
    ]
    cmd.extend(base_cmd)

    return cmd


def main():
    module = AnsibleModule(
        argument_spec=dict(
            ipaddress=dict(type='str', required=True),
            interface=dict(type='str', required=True),
            times=dict(type='str',default='3'),
            interval=dict(type='str',default='1'),
            nettype=dict(type='str', required=True)
        ),
        supports_check_mode=True,
    )

    ipaddress = module.params.get('ipaddress')
    interface = module.params.get('interface')
    times = module.params.get('times')
    nettype = module.params.get('nettype')
    interval = module.params.get('interval')
    address_list = ipaddress.split(',')
    ping_info = []
    for address in address_list:
        if address:
            address_info = address.split('_')[0]
            cmd = build_ping_cmd(times, interval, interface, address_info )
            rc, out, err = module.run_command(cmd)
            dest_host = address.split('_')[1]
            ping_info_dict = { 'ipaddress': address_info, 'interface': interface, 'dest_host': dest_host, 'nettype':nettype, 'status':rc, 'out': out}
            ping_info.append(ping_info_dict)
    # send_speed = out.get('end').get('streams')[0].get('sender').get('bits_per_second')
    result = dict(
        stdout=ping_info,
        changed=False,
        stdout_lines=ping_info
    )
    module.exit_json(**result)


if __name__ == '__main__':
    main()