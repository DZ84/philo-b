FROM nginx:stable

# These are handy for debugging: 
RUN apt-get update && apt-get install -y vim net-tools 

COPY ./conf/nginx.conf /etc/nginx/nginx.conf
RUN rm /etc/nginx/conf.d/default.conf

RUN touch /var/run/nginx.pid && \
	chown -R www-data:www-data /var/run/nginx.pid && \
	chown -R www-data:www-data /var/cache/nginx

USER www-data

