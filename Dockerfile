# syntax=docker/dockerfile:1.7

# --- Strategy ---
# Build stage: use official `caddy:builder` (this tag exists and tracks latest builder)
# Runtime stage: use official `caddy:latest`
# You can override these via build args in CI if needed.

ARG CADDY_BUILDER_TAG=builder
ARG CADDY_RUNTIME_TAG=latest

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

# ---------- Build stage ----------
FROM caddy:${CADDY_BUILDER_TAG} AS builder
ARG PLUGINS

# If CI network is slow to fetch Go modules, you may uncomment the next line:
# ENV GOPROXY=https://goproxy.cn,direct

# Use BuildKit cache mounts for faster, reproducible builds
RUN --mount=type=cache,target=/go/pkg/mod \
    --mount=type=cache,target=/root/.cache/go-build \
    xcaddy build ${PLUGINS}

# ---------- Runtime stage ----------
FROM caddy:${CADDY_RUNTIME_TAG}

# Replace the stock caddy binary with the plugin-enabled one we just built
COPY --from=builder /usr/bin/caddy /usr/bin/caddy

# Same mount points as the official image: /etc/caddy /data /config
# No ENTRYPOINT/CMD needed; inherit from upstream.

