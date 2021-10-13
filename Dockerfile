FROM elixir:1.12.3-alpine

RUN apk add postgresql-client && \
  apk add build-base && \
  rm -rf /var/cache/apk/*

# Just using dev for this example program
ENV MIX_ENV dev

# Install hex package manager and rebar
# By using --force, we don’t need to type “Y” to confirm the installation
RUN mix do local.hex --force, local.rebar --force

# Cache elixir dependecies and lock file
COPY mix.* ./

# Install and compile
RUN mix do deps.get
RUN mix deps.compile

# Copy all application files
COPY . ./

RUN mix do compile

RUN chmod +x docker_start.sh
EXPOSE 4000
CMD ["/docker_start.sh"]