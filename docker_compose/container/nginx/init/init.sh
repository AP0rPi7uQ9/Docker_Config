#!/bin/sh
echo "Running Nginx Init.sh Successful!"
if [ -f "/www/container/nginx/init/certbot.sh" ];then
	chmod +x /www/container/nginx/init/certbot.sh
	sh /www/container/nginx/init/certbot.sh
	mv /www/container/nginx/init/certbot.sh /www/container/nginx/init/certbot.sh.lock
fi
