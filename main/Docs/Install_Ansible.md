#### Node.js && NPM

```bash
> apt install nodejs npm -y
> npm install npm --global
```

#### Python

```bash
> sudo apt install python3-pip git pwgen -y
```

#### Ansible

```bash
> sudo apt install ansible -y
```

```bash
> ansible --version
ansible 2.10.8
  config file = None
  configured module search path = ['/home/user/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python3/dist-packages/ansible
  executable location = /usr/bin/ansible
  python version = 3.10.6 (main, Nov 14 2022, 16:10:14) [GCC 11.3.0]


```

#### Docker && Docker Compose

```bash
# 下载必要的依赖
> sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
```

```bash
# 添加 Docker CE 的仓库
# 阿里云：mirrors.aliyun.com
# 官方：download.docker.com
> curl -fsSL https://mirrors.aliyun.com/docker-ce/linux/ubuntu/gpg | sudo apt-key add -

# 注意 Ubuntu 系统别名
# 20.04：focal
# 22.04：jammy
> sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu jammy stable"
```

```bash
# 更新仓库缓存
> sudo apt update -y
# 安装 docker-ce
> sudo apt install docker-ce -y
# 安装 docker-compose
> sudo apt install docker-compose -y
```

```bash
> docker --version
# Docker version 20.10.22, build 3a2c30b

> docker-compose --version
# docker-compose version 1.29.2, build unknown
```

```bash
# 安装 Docker Compose 当前版本对应的 Python 模块
> pip3 install docker-compose==1.29.2
```

#### Ansible-AWX

```bash
# 17.1.0 以上的版本都是依赖 k8s 的，不推荐
# 下载，解压
> wget https://github.com/ansible/awx/archive/17.1.0.zip
> unzip 17.1.0.zip
```

```bash
# 生成 key
> pwgen -N 1 -s 40
# eMyJLuLsDTlqjOinT1mJnZA7u9NkvlqCvAtmmiz3
```

```bash
> cd awx-17.1.0/installer/

# 编辑 inventory
> sudo vi inventory
# 修改如下：
admin_user=admin
admin_password=admin
secret_key=eMyJLuLsDTlqjOinT1mJnZA7u9NkvlqCvAtmmiz3
```

```bash
# 通过 ansible 安装
sudo ansible-playbook -i inventory install.yml
```


