# perhaps go for stable
FROM nginx:latest

# These are handy for debugging. 
RUN apt-get update && apt-get install -y vim net-tools 

COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY ./conf/default.conf /etc/nginx/conf.d/default.conf

RUN touch /var/run/nginx.pid && \
	# chown -R person:person /var/run/nginx.pid && \
	# chown -R person:person /var/cache/nginx

	chown -R www-data:www-data /var/run/nginx.pid && \
	chown -R www-data:www-data /var/cache/nginx

USER www-data

