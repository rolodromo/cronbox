FROM node:10-alpine
RUN mkdir /app
WORKDIR /app
COPY . .
RUN npm ci
ENV PATH="/app/bin:${PATH}"
COPY cronbox_schedule /var/spool/cron/crontabs/root
RUN chmod +x /app/bin -R
CMD crond -l 2 -f
