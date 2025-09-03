# syntax=docker/dockerfile:1.7
ARG CADDY_VERSION=v2.10.2
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

FROM caddy:${CADDY_VERSION}-builder AS builder
ARG CADDY_VERSION
ARG PLUGINS
RUN --mount=type=cache,target=/go/pkg/mod \
    --mount=type=cache,target=/root/.cache/go-build \
    xcaddy build ${CADDY_VERSION} ${PLUGINS}

FROM caddy:${CADDY_VERSION}
COPY --from=builder /usr/bin/caddy /usr/bin/caddy
# 与官方保持一致：/etc/caddy /data /config 作为常用挂载点
