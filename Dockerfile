# Base image
FROM ruby:2.6.3

# Setup environment variables that will be available to the instance
ENV APP_HOME /production

RUN curl https://deb.nodesource.com/setup_12.x | bash
RUN curl https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# Installation of dependencies
RUN apt-get update \
  && apt-get install -y \
      # Needed for certain gems
    build-essential \
         # Needed for postgres gem
    libpq-dev \
         # Needed for asset compilation
    nodejs yarn \
    # The following are used to trim down the size of the image by removing unneeded data
  && apt-get clean autoclean \
  && apt-get autoremove -y \
  && rm -rf \
    /var/lib/apt \
    /var/lib/dpkg \
    /var/lib/cache \
    /var/lib/log

# Create a directory for our application
# and set it as the working directory
RUN mkdir $APP_HOME

COPY Gemfile* $APP_HOME/
COPY package*.json $APP_HOME/

WORKDIR $APP_HOME
RUN bundle install --full-index
RUN yarn install

# Copy over our application code
COPY . $APP_HOME/

RUN SECRET_KEY_BASE=`bundle exec rake secret` RAILS_ENV=production bundle exec rake assets:precompile
CMD bundle exec rails s -p ${PORT} -b '0.0.0.0'
