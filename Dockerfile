# syntax=docker/dockerfile:1

ARG RUBY_VERSION=3.2.2

FROM ruby:${RUBY_VERSION}-slim

# OS Level Dependencies
RUN --mount=type=cache,target=/var/cache/apt \
  --mount=type=cache,target=/var/lib/apt,sharing=locked \
  --mount=type=tmpfs,target=/var/log \
  rm -f /etc/apt/apt.conf.d/docker-clean; \
  echo 'Binary::apt::APT::Keep-Downloaded-Packages "true";' > /etc/apt/apt.conf.d/keep-cache; \
  apt-get update -qq \
  && apt-get install -yq --no-install-recommends \
    build-essential \
    gnupg2 \
    less \
    git \
    libpq-dev \
    postgresql-client \
    libvips \
    curl \
    nodejs \
    vim \
    graphviz

ENV LANG=C.UTF-8 \
  BUNDLE_JOBS=4 \
  BUNDLE_RETRY=3
  
RUN gem update --system && gem install bundler

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle check || bundle install --jobs 4

COPY . .
