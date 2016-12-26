FROM m4ucorp/tools:docker-rails.ruby-2.3.0
MAINTAINER Elifarley Cruz <elifarley.cruz@m4u.com.br>
MAINTAINER Leonardo Bernardelli <leonardo.bernardelli@m4u.com.br>

COPY puma.rb /etc/
COPY $_USER-service.sh $_USER.sh $HOME/
# Possible rocker bug: $HOME is empty
RUN chmod -R 700 /etc/my_init.d && echo "$HOME" > /etc/container_environment/HOME && \
  printf '#!/bin/bash\ntar -jxf vendor.tbz -C "$HOME"/vendor' > /etc/my_init.d/01-vendor-cache.sh

ONBUILD COPY Gemfile* ./
#ONBUILD MOUNT vendor:/app/vendor
ONBUILD COPY vendor /app/vendor
ONBUILD RUN bundle install --no-cache --jobs 4 --retry 3 --local && \
  rm -rf "./gem-home"/cache

ONBUILD RUN mkdir -p /etc/service/app && mv /app/app-service.sh /etc/service/app/run && chmod +x /etc/service/app/run
ONBUILD COPY . /app/
ONBUILD RUN chown -R nobody:nogroup /app ; chmod -f +x app.sh; \
if test -f crontab; then \
  chown app:crontab crontab && chmod 600 crontab && \
  mv crontab /var/spool/cron/crontabs/app; \
fi; \
if test -f db-migrate.sh; then \
  chown root:root db-migrate.sh && chmod 700 db-migrate.sh && \
  mv db-migrate.sh /etc/my_init.d/90-db-migrate.sh; \
fi;

ONBUILD EXPOSE 8080

