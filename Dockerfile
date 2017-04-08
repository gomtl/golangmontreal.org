FROM alpine:edge

RUN apk --no-cache add tini git openssh-client \
    && apk --no-cache add --virtual devs tar curl

# Install Caddy Server and some middleware
RUN curl "https://caddyserver.com/download/build?os=linux&arch=amd64&features=git%2Cprometheus%2Crealip" \
    | tar --no-same-owner -C /usr/bin/ -xz caddy

RUN curl -L "https://github.com/spf13/hugo/releases/download/v0.19/hugo_0.19_Linux-64bit.tar.gz" | tar -vxzf - -C /tmp/ && mv /tmp/hugo*/hugo* /usr/bin/hugo && rm -rf /tmp/hugo*

# Remove build devs
#RUN apk del devs

ADD ./config.yaml /app/config.yaml
ADD ./archetypes /app/archetypes
ADD ./content /app/content
ADD ./i18n /app/i18n
ADD ./layouts /app/layouts
ADD ./public /app/public
ADD ./static /app/static
ADD ./themes /app/themes

ADD ./Caddyfile /etc/Caddyfile

RUN cd /app; /usr/bin/hugo

ENTRYPOINT ["/sbin/tini"]

CMD ["caddy", "--conf", "/etc/Caddyfile"]