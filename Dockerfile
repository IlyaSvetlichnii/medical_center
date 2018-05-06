# vim: set syntax=dockerfile:
FROM ruby:2.5.0

RUN mkdir -p /app
WORKDIR /app

RUN \
  apt-get update -y && apt-get install -y \
  imagemagick \
  nodejs \
  libxml2-dev \
  libxslt-dev

ADD Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install --jobs 20 --retry 5 --without development test --deployment

ENV RAILS_ENV production
ENV RACK_ENV production

ADD . ./

RUN bundle exec rake assets:precompile

VOLUME /app/public

CMD bundle exec rake db:migrate; bundle exec puma -C config/puma.rb
