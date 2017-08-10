FROM ruby:2.4-alpine

ENV APP_HOME /usr/src/app
ENV RAILS_ENV development
ENV RACK_ENV development
ENV IMIMAPS_ENVIRONMENT docker

EXPOSE 80

WORKDIR $APP_HOME

COPY Gemfile* $APP_HOME/
COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

# general dependencies
RUN set -ex \
  && apk add --no-cache libpq imagemagick nodejs bash

# poltergeist, see https://github.com/Overbryd/docker-phantomjs-alpine/releases
RUN apk update && apk add --no-cache fontconfig curl && \
  mkdir -p /usr/share && \
  cd /usr/share \
  && curl -L https://github.com/Overbryd/docker-phantomjs-alpine/releases/download/2.11/phantomjs-alpine-x86_64.tar.bz2 | tar xj \
  && ln -s /usr/share/phantomjs/phantomjs /usr/bin/phantomjs \
  && phantomjs --version

# build deps
RUN set -ex \
  && apk add --no-cache --virtual .builddeps \
       linux-headers \
       libpq \
       tzdata \
       build-base \
       postgresql-dev \
       imagemagick-dev \
  && bundle install \
  && apk del .builddeps

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD export QMAKE=/usr/lib/qt5/bin/qmake
CMD export PATH=/usr/lib/qt5/bin/qmake:$PATH
CMD ["bundle", "exec", "unicorn", "--port", "80"]
