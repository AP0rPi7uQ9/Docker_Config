# Install

**Use root account**

1.Clone and Change ENV variable

```shell script
git clone https://github.com/AP0rPi7uQ9/Docker_Config.git
vim Docker_Config/init_server_shell/init_server.sh
```
Change ENV variable to yours.



2.Run init script

```shell script
chmod +x Docker_Config/init_server_shell/init_server.sh && sh Docker_Config/init_server_shell/init_server.sh
```



**If you log in with a PubicKey**

```
mkdir /home/(YOUR_USERNAME)/.ssh
cp /root/.ssh/authorized_keys /home/(YOUR_USERNAME)/.ssh/authorized_keys
chown -R (YOUR_USERNAME) /home/(YOUR_USERNAME)/.ssh
```



# Configuration

## Start up container

```
sudo docker-compose up -d
```



## MariaDB

**Configure MariaDB**

Get container ID of MariaDB

```
sudo docker ps
```

For example, 6f7ceb7a8ddc is container id

```
sudo docker exec -it 6f7ceb7a8ddc /bin/bash
mysql_secure_installation
```

