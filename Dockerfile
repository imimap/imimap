FROM ruby:2.7.2-alpine3.12

ENV APP_HOME /usr/src/app
ENV IMIMAPS_ENVIRONMENT docker

EXPOSE 80

WORKDIR $APP_HOME

COPY Gemfile* $APP_HOME/

# general dependencies
RUN apk update
RUN set -ex \
  && apk add --no-cache libpq nodejs bash gcompat git \
  && gem install bundler:2.1.4

# poltergeist, see https://github.com/Overbryd/docker-phantomjs-alpine/releases
ENV PHANHOME /usr/share
RUN apk add --no-cache fontconfig curl && \
  mkdir -p $PHANHOME \
  && curl -L https://github.com/Overbryd/docker-phantomjs-alpine/releases/download/2.11/phantomjs-alpine-x86_64.tar.bz2 | tar xj -C $PHANHOME \
  && ln -s $PHANHOME/phantomjs/phantomjs /usr/bin/phantomjs \
  && phantomjs --version

# build dependencies
RUN set -ex \
  && apk add --no-cache --virtual builddependencies \
      linux-headers \
      libpq \
      tzdata \
      build-base \
      postgresql-dev \
 && bundle install \
 && apk del builddependencies

CMD ["bundle", "exec", "unicorn", "--port", "80"]
