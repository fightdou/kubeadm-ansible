# Automatic Genrate Openstack Password

gen-password charts 可以自动生成部署openstack环境所需要的密码

## Parameters


### 自动生成openstack dependency 相关密码

| Name                                       | Form title             | Description                               | Value                |
| ------------------------------------------ | ---------------------- | ----------------------------------------- | -------------------- |
| `secretName`                               | secret 名称              | 生成openstack相关密码的secret名称                  | `openstack-password` |
| `passwordEnvs.mariadb-root-password`       | root 密码                | 数据库 root 用户密码                             | `""`                 |
| `passwordEnvs.keystone-database-password`  | Keystone 数据库密码         | Keystone 数据库密码                            | `""`                 |
| `passwordEnvs.keystone-admin-password`     | Keystone admin 用户密码    | Keystone admin 用户密码                       | `""`                 |
| `passwordEnvs.glance-database-password`    | Glance 数据库密码           | Glance 数据库密码                              | `""`                 |
| `passwordEnvs.glance-keystone-password`    | Glance 用户密码            | Glance 用户密码                               | `""`                 |
| `passwordEnvs.cinder-database-password`    | Cinder 数据库密码           | Cinder 数据库密码                              | `""`                 |
| `passwordEnvs.cinder-keystone-password`    | Cinder 用户密码            | Cinder 用户密码                               | `""`                 |
| `passwordEnvs.neutron-database-password`   | Neutron 数据库密码          | Neutron 数据库密码                             | `""`                 |
| `passwordEnvs.neutron-keystone-password`   | Neutron 用户密码           | Neutron 用户密码                              | `""`                 |
| `passwordEnvs.nova-database-password`      | Nova 数据库密码             | Nova 数据库密码                                | `""`                 |
| `passwordEnvs.nova-keystone-password`      | Nova 用户密码              | Nova 用户密码                                 | `""`                 |
| `passwordEnvs.placement-database-password` | Placement 数据库密码        | Placement 数据库密码                           | `""`                 |
| `passwordEnvs.placement-keystone-password` | Placement 用户密码         | Placement 用户密码                            | `""`                 |
| `passwordEnvs.rabbitmq-password`           | Rabbitmq 用户密码          | Rabbitmq 用户密码                             | `""`                 |
| `passwordEnvs.rbd_secret_uuid`             | rbd secret uuid        | rbd_secret_uuid is only used for nova     | `""`                 |
| `passwordEnvs.cinder_rbd_secret_uuid`      | cinder rbd secret uuid | cinder_rbd_secret_uuid is used for cinder | `""`                 |
