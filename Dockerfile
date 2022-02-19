# syntax=docker/dockerfile:1
FROM ruby:2.7.3
ARG master_key
ENV RAILS_ENV production
ENV RAILS_MASTER_KEY=$master_key

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client vim
WORKDIR /quest-custom-ror
COPY Gemfile /quest-custom-ror/Gemfile
COPY Gemfile.lock /quest-custom-ror/Gemfile.lock
RUN gem install bundler -v 2.2.27
RUN bundle install

# Add a script to be executed every time the container starts.
COPY bin/entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0", "-p", "3000"]
