FROM nginx:1.19

# -e导致命令停止任何错误.更典型的语法是用&&和/或停止任何错误.
# -x使shell输出正在运行的每个命令.这对于调试脚本很有用.
RUN set -ex; \
mv /etc/apt/sources.list /etc/apt/sources.list.bak

ADD sources.list /etc/apt/

RUN set -ex; \
    apt update \
    && apt-get install -y vim certbot python-certbot-nginx \
	&& mkdir /etc/nginx/nginxconfig.io/ \
	&& mkdir /etc/nginx/sites-available/ \
	&& mkdir /etc/nginx/reserve/ \
	&& mkdir /etc/nginx/config/

RUN set -ex; \
    mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.bak \
    && echo "include /etc/nginx/config/nginx.conf;" \
>> /etc/nginx/nginx.conf

###
# NginxConfig.io Download
###

# /etc/nginx/nginxconfig.io/letsencrypt.conf
ADD letsencrypt.conf /etc/nginx/nginxconfig.io/


#/etc/nginx/nginxconfig.io/general.conf
ADD general.conf /etc/nginx/nginxconfig.io/


#/etc/nginx/nginxconfig.io/security.conf
ADD security.conf /etc/nginx/nginxconfig.io/


#/etc/nginx/nginxconfig.io/proxy.conf
ADD proxy.conf /etc/nginx/nginxconfig.io/


###
# NginxConfig.io SSL Init
###

RUN set -ex; \
 	openssl dhparam -out /etc/nginx/dhparam.pem 2048 \
	&& mkdir -p /var/www/_letsencrypt \
	&& chown nginx /var/www/_letsencrypt

CMD nginx -g 'daemon off;' ; (chmod +x /www/container/nginx/init/init.sh && sh /www/container/nginx/init/init.sh)
#CMD ["nginx", "-g", "daemon off;"]