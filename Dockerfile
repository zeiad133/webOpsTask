FROM ruby:2.6-alpine

RUN apk update && apk upgrade && apk add ruby ruby-json ruby-io-console ruby-bundler ruby-irb ruby-bigdecimal tzdata postgresql-dev && apk add nodejs && apk add curl-dev ruby-dev build-base libffi-dev && apk add build-base libxslt-dev libxml2-dev ruby-rdoc mysql-dev sqlite-dev

RUN mkdir /app
WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN gem install ovirt-engine-sdk -v '4.3.0' --source 'https://rubygems.org/'
RUN bundle install --binstubs

COPY . .

EXPOSE 3000
# CMD ["bundle","exec", "sideqie"]
ENTRYPOINT ["sh", "./config/docker/startup.sh"]
# RUN rails db:migrate 2>/dev/null || rails db:create db:migrate
# CMD ["rails", "server", "-b", "0.0.0.0"]