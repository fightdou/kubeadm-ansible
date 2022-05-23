#!/usr/bin/env python

from ansible.module_utils.basic import *
import uuid


def main():
    module = AnsibleModule(
        argument_spec=dict(
            res_ping_reg_res=dict(type='list'),
        )
    )
    res_ping_reg_res = module.params['res_ping_reg_res']
    param_ping_res = []
    for res_ping in res_ping_reg_res:
        stdout_lines = res_ping.get('stdout_lines')
        ## 获取执行的每次ping的信息
        for stdout in stdout_lines:
            status = stdout.get('status')
            nettype = stdout.get('nettype')
            dest_host = stdout.get('dest_host')
            out = stdout.get('out').splitlines()
            stdout_lines_len = len(out)
            packet_loss_rate_line_split = out[stdout_lines_len-2].split(',')
            packet_loss_rate = packet_loss_rate_line_split[2]
            if status:
                sudu = 0
            else: 
                sudu_line = out[stdout_lines_len-1]
                sudu_line_split = sudu_line.split('=')
                sudu_line_split1_split = sudu_line_split[1].split('/')
                sudu = sudu_line_split1_split[1]
            dest_ip = stdout.get('ipaddress')
            card_name = stdout.get('interface')
            uuid_ping = str(uuid.uuid4())
            ping_map = {'status':status, 'plr':packet_loss_rate, 'sudu':sudu, 'card_name':card_name, 'nettype': nettype, 'dest_host':dest_host, 'dest_ip':dest_ip, 'uuid':uuid_ping }
            param_ping_res.append(ping_map)

    module.exit_json(changed=False,param_ping_res=param_ping_res)

if __name__ == '__main__':
    main()