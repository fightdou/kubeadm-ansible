# kubeadm-ansible

## 配置主机清单

修改 hosts 文件，将部署环境的节点信息配置进去

## 修改 globals 文件

需修改 ceph-globals.yaml 与 globals_vars.yaml

## 安装 ansible

```
apt update
apt install software-properties-common
add-apt-repository --yes --update ppa:ansible/ansible
apt install ansible
```

## 部署脚本

首先 部署 ceph 环境

```
cd kubeadm-ansible
ansible-playbook -i etc_example/hosts -e @etc_example/global_vars.yaml -e @etc_example/ceph-globals.yaml ceph-ansible/ceph-deploy.yaml
```

部署其他服务

```
ansible-playbook -i etc_example/hosts -e @etc_example/global_vars.yaml -e @etc_example/ceph-globals.yaml ansible/90-setup.yaml
```