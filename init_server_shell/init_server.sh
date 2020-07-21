#!/bin/sh
SUDO_USER="username"
SUDO_PASSWORD="password"
SSH_FILE=/etc/ssh/sshd_config
SSH_PORT=22
MARIADB_PORT=3306
REDIS_PORT=6379
POSTGRES_USER=postgres
POSTGRES_PASSWORD=postgres
POSTGRES_PORT=5432
INCHINA="true"
if [ ! -f "/etc/apt/sources.list.bak" ]; then
    mv /etc/apt/sources.list /etc/apt/sources.list.bak
fi
if [ "$INCHINA" = "true" ]; then
    sudo cat <<EOF >/etc/apt/sources.list
deb http://mirrors.tuna.tsinghua.edu.cn/debian/ buster main contrib non-free
# deb-src http://mirrors.tuna.tsinghua.edu.cn/debian/ buster main contrib non-free
deb http://mirrors.tuna.tsinghua.edu.cn/debian/ buster-updates main contrib non-free
# deb-src http://mirrors.tuna.tsinghua.edu.cn/debian/ buster-updates main contrib non-free
deb http://mirrors.tuna.tsinghua.edu.cn/debian/ buster-backports main contrib non-free
# deb-src http://mirrors.tuna.tsinghua.edu.cn/debian/ buster-backports main contrib non-free
deb http://mirrors.tuna.tsinghua.edu.cn/debian-security buster/updates main contrib non-free
# deb-src http://mirrors.tuna.tsinghua.edu.cn/debian-security buster/updates main contrib non-free
EOF
else
  sudo cat <<EOF >/etc/apt/sources.list
deb http://deb.debian.org/debian/ buster main contrib non-free
# deb-src http://deb.debian.org/debian/ buster main contrib non-free
deb http://deb.debian.org/debian/ buster-updates main contrib non-free
# deb-src http://deb.debian.org/debian/ buster-updates main contrib non-free
deb http://deb.debian.org/debian/ buster-backports main contrib non-free
# deb-src http://deb.debian.org/debian/ buster-backports main contrib non-free
deb http://security.debian.org/debian-security buster/updates main contrib non-free
# deb-src http://security.debian.org/debian-security buster/updates main contrib non-free
EOF
fi
  apt update \
	&& apt install -y unzip \
  && echo "===============Start creating user===============" \
	&& useradd -m $SUDO_USER -g sudo -s /bin/bash -d /home/$SUDO_USER \
	&& echo $SUDO_USER:$SUDO_PASSWORD |chpasswd \
  && echo "===============End of creating user===============" \
  && echo "===============Start configuring the SSH file===============" \
	&& sed -i "s/#Port 22/Port $SSH_PORT/" $SSH_FILE \
	&& sed -i 's/PermitRootLogin yes/PermitRootLogin no/' $SSH_FILE \
  && echo "===============End of configuration SSH file===============" \
	&& su - $SUDO_USER  <<!
cd /home/$SUDO_USER \
	&& echo $SUDO_PASSWORD | sudo -S apt install -y git \
	&& sudo apt-get -y update \
  && echo "===============Prepare to install docker===============" \
	&& sudo apt-get -y install apt-transport-https ca-certificates curl software-properties-common \
	&& sudo apt-get install -y gnupg2 \
	&& curl -fsSL https://mirrors.aliyun.com/docker-ce/linux/debian/gpg | sudo apt-key add - \
	&& sudo add-apt-repository "deb [arch=amd64] https://mirrors.aliyun.com/docker-ce/linux/debian $(lsb_release -cs) stable" \
	&& sudo apt-get -y update \
	&& sudo apt-get -y install docker-ce docker-ce-cli containerd.io \
  && echo "===============Docker installed successfully===============" \
  && echo "===============Prepare to install docker-compose===============" \
	&& if [ "$INCHINA" == "true" ]; then sudo curl -L "https://get.daocloud.io/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose; else sudo curl -L "https://github.com/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose; fi \
  && sudo chmod +x /usr/local/bin/docker-compose \
  && sudo mv ../docker_compose /www \
  && sudo chown -R $SUDO_USER /www/ \
  && sed -i "s/MariaDB Port/$MARIADB_PORT/" /www/docker-compose.yml \
  && sed -i "s/Redis Port/$REDIS_PORT/" /www/docker-compose.yml \
  && sed -i "s/Postgres Port/$POSTGRES_PORT/" /www/docker-compose.yml \
  && sed -i "s/postgres_user/$POSTGRES_USER/" /www/docker-compose.yml \
  && sed -i "s/postgres_password/$POSTGRES_PASSWORD/" /www/docker-compose.yml \
  && echo "===============Docker-compose installed successfully===============" \
  && echo "===============Configuring iptables===============" \
  && (sudo bash -c "cat <<EOF >/etc/iptables.rules
*filter
-P INPUT DROP
-P OUTPUT ACCEPT
-A INPUT -i lo -j ACCEPT
-A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
-A INPUT -p tcp --dport $SSH_PORT -j ACCEPT
-A INPUT -p tcp --dport $MARIADB_PORT -j ACCEPT
-A INPUT -p tcp --dport $REDIS_PORT -j ACCEPT
-A INPUT -p tcp --dport $POSTGRES_PORT -j ACCEPT
-A INPUT -p tcp --dport 80 -j ACCEPT
-A INPUT -p tcp --dport 443 -j ACCEPT
COMMIT
EOF") \
  && sudo iptables-restore < /etc/iptables.rules \
  && (sudo bash -c "cat <<EOF >/etc/network/if-pre-up.d/iptables
#!/bin/bash
/sbin/iptables-restore < /etc/iptables.rules
EOF") \
  && sudo chmod +x /etc/network/if-pre-up.d/iptables \
  && echo "===============Iptables configuration complete===============" \
  && echo "===============Restart service===============" \
  && sudo systemctl restart docker \
	&& sudo systemctl restart ssh
!