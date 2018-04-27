FROM alpine:3.4

RUN echo "nobody:x:65534:65534:nobody:/nonexistent:/bin/sh" > /etc/passwd 
COPY ./entrypoint.sh /entrypoint.sh

EXPOSE 80

COPY httpd.conf /etc/httpd.conf
RUN apk update && apk add nodejs
RUN npm install -g uglify-js
RUN mkdir -p /var/www/mender-gui
COPY dist/ /var/www/mender-gui/dist/

WORKDIR /var/www/mender-gui/dist/

ENTRYPOINT ["/entrypoint.sh"]
