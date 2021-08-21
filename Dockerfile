FROM ruby:3-bullseye
RUN apt-get update -qq && apt-get install -y nodejs npm
RUN npm install --global yarn
RUN apt-get clean all

WORKDIR /usr/src/myapp
COPY Gemfile /usr/src/myapp/Gemfile
COPY Gemfile.lock /usr/src/myapp/Gemfile.lock
RUN bundle install
RUN bundle exec rails webpacker:install
RUN bundle exec rails webpacker:compile


EXPOSE 3000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]
