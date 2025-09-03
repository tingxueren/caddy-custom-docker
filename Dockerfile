# syntax=docker/dockerfile:1.7
# Always follow the official latest runtime/builder images
ARG CADDY_IMAGE_VERSION=latest

# Plugins to build in (append/remove as needed)
ARG PLUGINS="\
  --with github.com/mholt/caddy-l4 \
  --with github.com/caddyserver/forwardproxy \
  --with github.com/mholt/caddy-webdav \
  --with github.com/WeidiDeng/caddy-cloudflare-ip \
  --with github.com/caddy-dns/cloudflare \
  --with github.com/caddy-dns/duckdns \
  --with github.com/caddy-dns/tencentcloud \
  --with github.com/mholt/caddy-events-exec \
  --with github.com/caddyserver/jsonc-adapter \
  --with github.com/imgk/caddy-trojan \
"

# Build stage
FROM caddy:${CADDY_IMAGE_VERSION}-builder AS builder
ARG PLUGINS
RUN --mount=type=cache,target=/go/pkg/mod \
    --mount=type=cache,target=/root/.cache/go-build \
    xcaddy build ${PLUGINS}

# Runtime stage
FROM caddy:${CADDY_IMAGE_VERSION}
COPY --from=builder /usr/bin/caddy /usr/bin/caddy
