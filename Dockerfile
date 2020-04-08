FROM ruby:2.6.3

ENV NODE_VERSION 12
ENV INSTALL_PATH /portal-solar-dev-test

RUN curl -sL https://deb.nodesource.com/setup_$NODE_VERSION.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -qq
RUN apt-get install -y --no-install-recommends nodejs postgresql-client \
      locales yarn

WORKDIR $INSTALL_PATH

RUN gem install bundler

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock

RUN bundle install

COPY . $INSTALL_PATH

ENTRYPOINT ["sh", "bin/entry/db_script.sh"]