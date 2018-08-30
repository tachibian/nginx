#Dockerfile for nginx

FROM tachibian/centos:ver7.5.1 
MAINTAINER Kazuhiro Tachibana
ENV HOME /root
USER root
WORKDIR /root
ADD init.d /etc/init.d/
ADD nginx-1.15.2.tar.gz  /root/
RUN yum -y install pcre-devel zlib-devel openssl-devel;\
    adduser -s /sbin/nologin nginx;\
    #tar -xzvf /root/nginx-1.15.2.tar.gz;\
    mkdir -p /usr/local/nginx-1.15.2;\
    ln -s /usr/local/nginx-1.15.2 /usr/local/nginx;\
    mkdir -p /usr/local/var/nginx/logs;\
    chown -R nginx:nginx /usr/local/var/nginx;\
    cd /root/nginx-1.15.2;\
    ./configure --user=nginx \ 
                --group=nginx \ 
                --prefix=/usr/local/nginx \
                --pid-path=/var/run/nginx.pid \
                --lock-path=/var/lock/subsys/nginx \ 
                --with-http_ssl_module \
                --with-http_v2_module \
                --with-http_realip_module \
                --with-http_addition_module \
                --with-http_sub_module \
                --with-http_gzip_static_module \
                --with-http_stub_status_module \
                --error-log-path=/usr/local/var/nginx/logs/error.log \
                --http-log-path=/usr/local/var/nginx/logs/access.log \
                --http-client-body-temp-path=/usr/local/var/nginx/client_body_temp \
                --http-proxy-temp-path=/usr/local/var/nginx/proxy_temp \
                --http-fastcgi-temp-path=/usr/local/var/nginx/fastcgi_temp \
                --http-uwsgi-temp-path=/usr/local/var/nginx/uwsgi_temp \
                --http-scgi-temp-path=/usr/local/var/nginx/scgi_temp;\
    make;\
    make install;\
    chkconfig --add nginx;
EXPOSE 80 443
ENTRYPOINT ["/sbin/init"] 
