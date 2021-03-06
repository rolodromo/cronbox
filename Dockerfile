FROM node:10-alpine

ENV RCLONE_VERSION=current
ENV RCLONE_ARCH=amd64
ENV RCLONE_CONFIG_REMOTE_TYPE=
ENV RCLONE_CONFIG_REMOTE_TOKEN=

RUN apk update && apk upgrade && \
    echo @edge http://nl.alpinelinux.org/alpine/edge/main >> /etc/apk/repositories && \
    echo @edge http://nl.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories

RUN apk add --no-cache libressl mongodb-tools@edge ca-certificates fuse wget

# RCLONE TOOL
RUN cd /tmp \
    && wget -q http://downloads.rclone.org/rclone-${RCLONE_VERSION}-linux-${RCLONE_ARCH}.zip \
    && unzip /tmp/rclone-${RCLONE_VERSION}-linux-${RCLONE_ARCH}.zip \
    && mv /tmp/rclone-*-linux-${RCLONE_ARCH}/rclone /usr/bin \
    && rm -r /tmp/rclone*

RUN mkdir /app
RUN mkdir -p /backup/mongodb

WORKDIR /app
COPY . .
RUN npm ci
ENV PATH="/app/bin:${PATH}"
COPY cronbox_schedule /var/spool/cron/crontabs/root
RUN chmod +x /app/bin -R
CMD crond -l 2 -f
