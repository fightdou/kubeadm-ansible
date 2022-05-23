from ansible.module_utils.basic import AnsibleModule
import json, uuid

def build_iperf3_cmd(ipaddersses, interval, times, server_port):
    '''
    build 'iperf3' command line to execute
    '''

    cmd = ['iperf3']

    base_cmd = [
        '-c',
        ipaddersses,
        '-i',
        interval,
        '-t',
        times,
        '-p',
        server_port,
        '--json'
    ]
    cmd.extend(base_cmd)

    return cmd


def build_iperf_map(rc, out, hostname, receive_hosts, net_card, net_type):
    uuid_iperf3 = str(uuid.uuid4())
    if rc:
        receive_map = {'client_hostname':hostname, 'server_host': receive_hosts,'net_type':net_type, 'net_card':net_card, 'receive_speed':0, 'send_speed':0, 'uuid':uuid_iperf3 }
    else:
        sperf3_end = out.get('end')
        # sperf3_end_stream = sperf3_end.get('streams')
        # sperf3_receiver = sperf3_end_stream[0].get('receiver')
        sperf3_receiver = sperf3_end.get('sum_received')
        receive_speed_all = sperf3_receiver.get('bits_per_second') 
        receive_speed = int(receive_speed_all) // 8 // (1024**2)
        #sperf3_sender = sperf3_end_stream[0].get('sender')
        sperf3_sender = sperf3_end.get('sum_sent')
        send_speed_all = sperf3_sender.get('bits_per_second') 
        send_speed = int(send_speed_all) // 8 // (1024**2)
        receive_map = {'client_hostname':hostname, 'server_host': receive_hosts,'net_type':net_type, 'net_card':net_card, 'receive_speed':receive_speed, 'send_speed':send_speed, 'uuid':uuid_iperf3 }

    return receive_map


def main():
    module = AnsibleModule(
        argument_spec=dict(
            server_ipaddress=dict(type='str', required=True),
            interval=dict(type='str', required=True),
            net_card=dict(type='str', required=True),
            times=dict(type='str',default='3'),
            hostname=dict(type='str',required=True),
            receive_hosts=dict(type='str',required=True),
            server_port=dict(type='str',required=True),
            net_type=dict(type='str',required=True)
            # controlspeed=dict(type='str', required=True),
            # nodespeed=dict(type='str', required=True)
        ),
        supports_check_mode=True,
    )

    ipaddress = module.params.get('server_ipaddress')
    interval = module.params.get('interval')
    net_card = module.params.get('net_card')
    times = module.params.get('times')
    hostname = module.params.get('hostname')
    receive_hosts = module.params.get('receive_hosts')
    server_port = module.params.get('server_port')
    net_type = module.params.get('net_type')
    # nodespeed = module.params.get('nodespeed')

    cmd = build_iperf3_cmd(ipaddress, interval, times, server_port)

    rc, out, err = module.run_command(cmd)
    out = json.loads(out)
    iperf_map = build_iperf_map(rc, out, hostname, receive_hosts, net_card , net_type)
    
    result = dict(
        rc=rc,
        param_iperf3_res=iperf_map,
        stderr=err,
        changed=False
    )
    
    module.exit_json(**result)


if __name__ == '__main__':
    main()