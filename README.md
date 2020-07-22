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



# Initial setup

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



# Deploy the application

## Nginx

Nginx example config URL

> https://www.digitalocean.com/community/tools/nginx?domains.0.server.path=%2Fwww%2Fwwwroot%2Fexample.com&domains.0.server.documentRoot=%2F&domains.0.server.wwwSubdomain=true&domains.0.https.letsEncryptEmail=example%40email.com&domains.0.php.php=false&domains.0.reverseProxy.reverseProxy=true&domains.0.reverseProxy.proxyPass=http%3A%2F%2F127.0.0.1%3A8080&domains.0.routing.root=false&domains.0.routing.index=index.html&domains.0.routing.fallbackHtml=true&domains.0.logging.accessLog=true&domains.0.logging.errorLog=true&global.https.ocspCloudflare=false&global.https.ocspGoogle=false&global.https.ocspOpenDns=false&global.security.contentSecurityPolicy=default-src%20%27self%27%20http%3A%20https%3A%20data%3A%20blob%3A%20%27unsafe-inline%27%20%27unsafe-eval%27&global.nginx.user=nginx