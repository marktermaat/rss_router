# ===== Build phase
FROM elixir:1.10-alpine as builder
ENV MIX_ENV=prod

# Copy code
COPY lib ./lib
COPY config ./config
COPY test ./test
COPY mix.exs ./mix.exs
COPY mix.lock ./mix.lock

# Build release
RUN mix local.rebar --force && \
  mix local.hex --force && \
  mix deps.get && \
  mix release

# ===== Deployment phase
FROM alpine:3.16

# Install bash and openssl
RUN apk add --no-cache --update bash openssl libgcc libstdc++ ncurses-libs

# Set environment variables and expose ports
EXPOSE 4000

# Set the working dir
WORKDIR /app

# Copy release
COPY --from=builder _build/prod/rel/rss_router/ .

# Run command
CMD ["/app/bin/rss_router", "start"]
