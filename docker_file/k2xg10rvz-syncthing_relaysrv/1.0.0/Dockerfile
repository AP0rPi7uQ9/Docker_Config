FROM debian:10.4

# -e导致命令停止任何错误.更典型的语法是用&&和/或停止任何错误.
# -x使shell输出正在运行的每个命令.这对于调试脚本很有用.
RUN set -ex; \
mv /etc/apt/sources.list /etc/apt/sources.list.bak

ADD sources.list /etc/apt/

ENV URL https://github.com/syncthing/relaysrv/releases/download/v1.3.1/syncthing-relaysrv_1.3.1_amd64.deb
ENV FILENAME syncthing-relaysrv_1.3.1_amd64.deb

RUN set -ex; \
    apt update \
	&& apt install -y vim wget curl git \
	&& wget -P /root $URL \
	&& dpkg -i /root/$FILENAME \
	&& mkdir /init

ADD init.sh /init/

#CMD ["bash"]
CMD chmod +x /init/init.sh && sh /init/init.sh && bash