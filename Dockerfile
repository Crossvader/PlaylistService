FROM ruby:2.3.1

MAINTAINER Keolo Keagy <keolo@kea.gy>

# Use utf-8 encoding.
# https://oncletom.io/2015/docker-encoding/
ENV LANG C.UTF-8

# Install dependencies:
# - build-essential: To ensure certain gems can be compiled
# - libpq-dev: Communicate with postgres through the postgres gem
# - postgresql-client: In case you want to talk directly to postgres
RUN apt-get update && \
    apt-get install -y --no-install-recommends --fix-missing \
      build-essential \
      libpq-dev \
      postgresql-client && \
    rm -rf /var/lib/apt/lists/*

# This sets the context of where commands will run and is documented on Docker's
# website extensively.
WORKDIR /usr/src/app

# Ensure gems are cached and only get updated when they change. This will
# drastically decrease build times when your gems do not change.
COPY Gemfile* ./
RUN bundle install

# Copy in the application code from your work station at the current directory
# over to the working directory in the container.
COPY . .

# Expose port for host machine.
EXPOSE 3000

# The default command that gets ran. This can be overridden in a Kubernetes
# manifest.
CMD ["rails", "server", "-b", "0.0.0.0"]
