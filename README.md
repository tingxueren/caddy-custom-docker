# Caddy Custom Docker Image (follow upstream latest)

[![Docker Pulls](https://img.shields.io/docker/pulls/tingxueren/caddy-custom.svg)](https://hub.docker.com/r/tingxueren/caddy-custom)
![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/tingxueren/caddy-custom?sort=date)
![Docker Version](https://img.shields.io/docker/v/tingxueren/caddy-custom?sort=semver)
[![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/tingxueren/caddy-custom-docker/publish.yml?branch=main)](https://github.com/tingxueren/caddy-custom-docker/actions)

本仓库提供的镜像基于 **官方 [caddy:latest](https://hub.docker.com/_/caddy)**，使用 [xcaddy](https://github.com/caddyserver/xcaddy) 自动构建并集成了常用插件。  

目标：**无需关注 Caddy 版本号，始终跟随官方最新，直接可用。**

---

## 内置插件

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

---

## 快速使用

运行方式与官方镜像保持一致：

```bash
docker run -d   -p 80:80 -p 443:443 -p 443:443/udp   -v $(pwd)/Caddyfile:/etc/caddy/Caddyfile   -v caddy_data:/data   -v caddy_config:/config   tingxueren/caddy-custom:latest
```

Caddyfile 示例（HTTP 直接返回文本）：

```Caddyfile
:80 {
  respond "Hello, Caddy Custom!"
}
```

访问 `http://localhost` 应返回 `Hello, Caddy Custom!`。

---

## 插件验证

查看已编译的模块：

```bash
docker run --rm tingxueren/caddy-custom:latest caddy list-modules
```

只看我们关心的插件：

```bash
docker run --rm tingxueren/caddy-custom:latest   caddy list-modules | grep -E 'layer4|forward_?proxy|webdav|cloudflare|duckdns|tencentcloud|events\.handlers\.exec|jsonc|trojan'
```

---

## 架构支持

- `linux/amd64`  
- `linux/arm64`  

---

## 自动构建

本仓库使用 GitHub Actions 自动构建：

- push 到 `main` 分支  
- 每周一 03:00 UTC 定时构建  
- 生成以下标签：  
  - `latest` — 跟随官方最新  
  - `sha-xxxx` — 对应 commit 短哈希  
  - `nightly` — 每周定时构建

---

## 参考

- [Caddy 官方仓库](https://github.com/caddyserver/caddy)  
- [Caddy Docker 官方镜像](https://hub.docker.com/_/caddy)  
- [xcaddy](https://github.com/caddyserver/xcaddy)  
