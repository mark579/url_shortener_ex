FROM node:fermium-alpine as BUILDER

WORKDIR /var/appbuild

COPY package.json .
COPY yarn.lock .
RUN yarn install --frozen-lockfile
COPY . .
RUN yarn build

FROM alpine:3.11 as FINAL
RUN apk add --no-cache nginx && \
  adduser -S deploy -g www-data && \
  chown -R deploy:www-data /var/log/nginx && \
  chown -R root:www-data /etc/init.d/nginx && \
  chown -R deploy:www-data /var/lib/nginx && \
  mkdir -p /var/lib/nginx/logs && \
  mkdir -p /var/lib/nginx/tmp && \
  mkdir /run/nginx && \
  touch /run/nginx/nginx.pid && \
  chown -R deploy:www-data /var/lib/nginx && \
  chown deploy:www-data /run/nginx/nginx.pid && \
  chown -R deploy:www-data /home/deploy && \
  chmod -R a+w /etc/nginx/conf.d
COPY --from=BUILDER /var/appbuild/build /var/www/frontend
COPY --chown=deploy:www-data docker/nginx.conf /etc/nginx/conf.d/default.conf
USER deploy
WORKDIR /usr/local/bin/

ENTRYPOINT nginx -g "daemon off;"