FROM debian:10.2

# -e导致命令停止任何错误.更典型的语法是用&&和/或停止任何错误.
# -x使shell输出正在运行的每个命令.这对于调试脚本很有用.
RUN set -ex; \
	mv /etc/apt/sources.list /etc/apt/sources.list.bak \
	&& echo "deb http://mirrors.tuna.tsinghua.edu.cn/debian/ buster main contrib non-free \n \
"#" deb-src http://mirrors.tuna.tsinghua.edu.cn/debian/ buster main contrib non-free \n \
deb http://mirrors.tuna.tsinghua.edu.cn/debian/ buster-updates main contrib non-free \n \
"#" deb-src http://mirrors.tuna.tsinghua.edu.cn/debian/ buster-updates main contrib non-free \n \
deb http://mirrors.tuna.tsinghua.edu.cn/debian/ buster-backports main contrib non-free \n \
"#" deb-src http://mirrors.tuna.tsinghua.edu.cn/debian/ buster-backports main contrib non-free \n \
deb http://mirrors.tuna.tsinghua.edu.cn/debian-security buster/updates main contrib non-free \n \
"#" deb-src http://mirrors.tuna.tsinghua.edu.cn/debian-security buster/updates main contrib non-free \n "\
>> /etc/apt/sources.list \
	&& apt-get update \
	&& apt-get install -y git wget \
	&& wget -P /root/download http://software.lllllllllllllllllllll.com:85/vlmcsd-1113.tar.gz \
	&& tar -xvf /root/download/vlmcsd-1113.tar.gz -C /root/download/

EXPOSE 1688

CMD /root/download/binaries/Linux/intel/static/vlmcsd-x64-musl-static && /bin/bash