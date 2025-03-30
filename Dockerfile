FROM ruby:2.7.8

RUN apt-get update && apt-get install -y nodejs mysql-client --no-install-recommends && rm -rf /var/lib/apt/lists/*

ARG APP_HOME

RUN mkdir -p $APP_HOME

WORKDIR $APP_HOME

ADD Gemfile $APP_HOME/

RUN bundle install

ADD . $APP_HOME