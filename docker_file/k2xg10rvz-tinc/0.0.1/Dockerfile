FROM debian:10.4

# -e导致命令停止任何错误.更典型的语法是用&&和/或停止任何错误.
# -x使shell输出正在运行的每个命令.这对于调试脚本很有用.
RUN set -ex; \
mv /etc/apt/sources.list /etc/apt/sources.list.bak

ADD sources.list /etc/apt/

RUN set -ex; \
    apt update \
	&& apt install -y vim wget curl git tinc \
	&& mkdir /tinc
	
ADD init.sh /tinc/

EXPOSE 655

#CMD ["bash"]
CMD  chmod +x /tinc/init.sh && sh /tinc/init.sh && bash