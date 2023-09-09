# syntax=docker/dockerfile:1

# Base image
ARG ALPINE_VERSION=3.16.2
ARG ELIXIR_VERSION=1.14.3
ARG ERLANG_VERSION=23.3.4.18

FROM hexpm/elixir:${ELIXIR_VERSION}-erlang-${ERLANG_VERSION}-alpine-${ALPINE_VERSION}

# Environment variables for PostgreSQL
ENV MIX_ENV=dev
ENV POSTGRES_USER=postgres 
ENV POSTGRES_PASSWORD=postgres
ENV POSTGRES_DB=ret_dev

ARG MIX_ENV=dev
ARG POSTGRES_USER=postgres 
ARG POSTGRES_PASSWORD=postgres
ARG POSTGRES_DB=ret_dev


ARG DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN apk add git postgresql wget inotify-tools postgresql-client

# Create app directory
WORKDIR /app

# Copy app files
COPY . .

# Install project dependencies
RUN mix do local.hex --force, local.rebar --force

# Fetch dependencies
RUN mix deps.get

#Create storage dev
RUN echo "mkdir storage/dev"
# Define the command to run your script
CMD ["mix", "phx.server"]
