### 参考

  https://docs.microsoft.com/zh-cn/dotnet/core/install/linux

### 通过 snap 在线安装

1. 使用 `--channel` 参数来指明要安装哪个版本。 如果省略此参数，则使用 `latest/stable`。 在下面的示例中，指定的是 `6.0`
   
   ```bash
   $ sudo snap install dotnet-sdk --classic --channel=6.0
   ```

2. 使用 `snap alias` 命令为系统注册 `dotnet` 命令
   
   ```bash
   $ sudo snap alias dotnet-sdk.dotnet dotnet
   ```

### 通过 apt-get 在线安装

1. 安装 .NET 之前，将 Microsoft 包签名密钥添加到受信任密钥列表，并添加包存储库
   
   ```bash
   $ wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb 
   $ sudo dpkg -i packages-microsoft-prod.deb
   $ rm packages-microsoft-prod.deb
   ```

2. 安装
   
   ```bash
   # aspnetcore-runtime-6.0/dotnet-runtime-6.0/dotnet-sdk-6.0
   $ sudo apt-get update; \  
       sudo apt-get install -y apt-transport-https && \  
       sudo apt-get update && \  
       sudo apt-get install -y dotnet-sdk-6.0
   ```

### 通过脚本安装

1. SDK 和运行时的自动化和非管理员安装，可通过 https://dot.net/v1/dotnet-install.sh 下载脚本

2. 授权
   
   ```bash
   $ chmod u+x dotnet-install.sh
   ```

3. 执行，需要 Bash 才能运行该脚本，最终安装目录：/root/.dotnet
   
   ```bash
   # aspnetcore
   $ ./dotnet-install.sh --runtime aspnetcore
   
   # netcore
   $ ./dotnet-install.sh --runtime netcore
   
   # SDK
   $ ./dotnet-install.sh -c 3.1  
   ```

4. 环境变量
   
   ```bash
   # export PATH=$PATH:/root/.dotnet
   $ vi ~/.bashrc
   $ source ~/.bashrc
   ```

5. 查看
   
   ```bash
   $ dotnet --info
   ```

### 手动安装

1. 拷贝 dotnet-runtime-3.1.14-linux-x64.tar.gz 到指定目录

2. 创建安装目录
   
   ```bash
   $ mkdir /home/dotnet
   ```

3. 解压
   
   ```bash
   $ tar -zxf dotnet-runtime-3.1.14-linux-x64.tar.gz -C /home/dotnet
   ```

4. 环境变量
   
   ```bash
   # export PATH=$PATH:/home/dotnet
   $ vi ~/.bashrc
   $ source ~/.bashrc
   ```

5. 查看
   
   ```bash
   $ dotnet --info
   ```

#### 22.04 上安装 3.1

1. 安装 .NET 之前，将 Microsoft 包签名密钥添加到受信任密钥列表，并添加包存储库
   
   ```bash
   $ wget https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb 
   $ sudo dpkg -i packages-microsoft-prod.deb
   $ rm packages-microsoft-prod.deb
   ```

2. 安装 libssl1.1
   
   ```bash
   $ wget http://security.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2.19_amd64.deb 
   $ sudo dpkg -i libssl1.1_1.1.1f-1ubuntu2.19_amd64.deb
   
   //或者
   $ echo "deb http://security.ubuntu.com/ubuntu focal-security main" | sudo tee /etc/apt/sources.list.d/focal-security.list
   $ sudo apt-get update
   $ sudo apt-get install libssl1.1
   ```

3. 安装 3.1
   
   ```bash
   $ sudo apt update
   $ sudo apt install aspnetcore-runtime-3.1
   ```

#### 卸载 NetCore

```bash
$ sudo apt remove 'dotnet*' 'aspnet*' 'netstandard*'
$ sudo rm -f /etc/apt/sources.list.d/microsoft-prod.list
$ sudo apt update
```