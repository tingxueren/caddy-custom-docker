# Caddy Custom Docker Image

[![Docker Pulls](https://img.shields.io/docker/pulls/tingxueren/caddy-custom.svg)](https://hub.docker.com/r/tingxueren/caddy-custom)
[![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/tingxueren/caddy-custom-docker/publish.yml)](https://github.com/tingxueren/caddy-custom-docker/actions)

自定义构建的 [Caddy v2.10.2](https://github.com/caddyserver/caddy) Docker 镜像，内置以下插件：

- [caddy-l4](https://github.com/mholt/caddy-l4) — L4/TCP/UDP 分流  
- [forwardproxy](https://github.com/caddyserver/forwardproxy) — 正向代理（NaiveProxy 支持）  
- [caddy-webdav](https://github.com/mholt/caddy-webdav) — WebDAV  
- [caddy-cloudflare-ip](https://github.com/WeidiDeng/caddy-cloudflare-ip) — Cloudflare IP 源支持  
- [caddy-trusted-cloudfront](https://github.com/SchumacherFM/caddy-trusted-cloudfront) — CloudFront 信任源  
- [caddy-dns/cloudflare](https://github.com/caddy-dns/cloudflare) — DNS-01 证书获取（Cloudflare）  
- [caddy-dns/duckdns](https://github.com/caddy-dns/duckdns) — DNS-01 证书获取（DuckDNS）  
- [caddy-dns/tencentcloud](https://github.com/caddy-dns/tencentcloud) — DNS-01 证书获取（腾讯云）  
- [caddy-events-exec](https://github.com/mholt/caddy-events-exec) — 事件触发执行  
- [jsonc-adapter](https://github.com/caddyserver/jsonc-adapter) — JSONC 配置支持  
- [caddy-trojan](https://github.com/imgk/caddy-trojan) — Trojan 协议支持  

👉 对齐官方 Caddy Docker 镜像的构建流程：  
使用 `caddy:<version>-builder` + `xcaddy` 构建二进制，再基于 `caddy:<version>` 作为 runtime。

---

## 用法

运行时和官方镜像保持一致：

```bash
docker run -d   -p 80:80 -p 443:443 -p 443:443/udp   -v $(pwd)/Caddyfile:/etc/caddy/Caddyfile   -v caddy_data:/data   -v caddy_config:/config   tingxueren/caddy-custom:latest
```

支持 `Caddyfile` 和 `caddy.json` 配置文件。默认挂载点与官方镜像一致：

- `/etc/caddy` → 配置文件目录  
- `/data` → 自动证书等数据  
- `/config` → 自动化状态  

---

## 插件验证

```bash
docker run --rm tingxueren/caddy-custom:latest   caddy list-modules | grep -E 'l4|forwardproxy|webdav|cloudflare|duckdns|tencentcloud|events-exec|jsonc|trojan'
```

---

## 多架构支持

- `linux/amd64`  
- `linux/arm64`

---

## 自动构建

- push 到 `main` 分支  
- 打 tag（如 `v2.10.2`）  
- 每周一定时构建（可在 `.github/workflows/publish.yml` 中调整）

---

## 参考

- [Caddy 官方仓库](https://github.com/caddyserver/caddy)  
- [Caddy Docker 官方镜像](https://hub.docker.com/_/caddy)  
- [xcaddy](https://github.com/caddyserver/xcaddy)  
