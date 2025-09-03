# Caddy Custom Docker Image (follow upstream latest)

[![Docker Pulls](https://img.shields.io/docker/pulls/tingxueren/caddy-custom.svg)](https://hub.docker.com/r/tingxueren/caddy-custom)
[![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/tingxueren/caddy-custom-docker/publish.yml)](https://github.com/tingxueren/caddy-custom-docker/actions)

本仓库提供的镜像基于 **官方 [caddy:latest](https://hub.docker.com/_/caddy)**，使用 `xcaddy` 自动构建并集成了常用插件。  
目标是：**无需关注 Caddy 版本号，始终跟随官方最新，直接可用。**

---

## 内置插件

- [caddy-l4](https://github.com/mholt/caddy-l4) — L4/TCP/UDP 分流  
- [forwardproxy](https://github.com/caddyserver/forwardproxy) — 正向代理（支持 Naive）  
- [caddy-webdav](https://github.com/mholt/caddy-webdav) — WebDAV 协议支持  
- [caddy-cloudflare-ip](https://github.com/WeidiDeng/caddy-cloudflare-ip) — Cloudflare IP 源识别  
- [caddy-dns/cloudflare](https://github.com/caddy-dns/cloudflare) — DNS-01 证书获取（Cloudflare）  
- [caddy-dns/duckdns](https://github.com/caddy-dns/duckdns) — DNS-01 证书获取（DuckDNS）  
- [caddy-dns/tencentcloud](https://github.com/caddy-dns/tencentcloud) — DNS-01 证书获取（腾讯云）  
- [caddy-events-exec](https://github.com/mholt/caddy-events-exec) — 生命周期事件触发执行命令  
- [jsonc-adapter](https://github.com/caddyserver/jsonc-adapter) — 支持 JSONC 格式配置  
- [caddy-trojan](https://github.com/imgk/caddy-trojan) — Trojan 协议支持  

---

## 使用方法

最小运行示例（与官方镜像保持一致的挂载点）：

```bash
docker run -d   -p 80:80   -p 443:443   -p 443:443/udp   -v $(pwd)/Caddyfile:/etc/caddy/Caddyfile:ro   -v caddy_data:/data   -v caddy_config:/config   tingxueren/caddy-custom:latest
```

- `/etc/caddy` → 配置文件目录（支持 Caddyfile 与 JSON 配置）  
- `/data` → 自动证书等持久化数据  
- `/config` → 内部状态保存  

---

## 插件验证

```bash
docker run --rm tingxueren/caddy-custom:latest   caddy list-modules | grep -E 'l4|forwardproxy|webdav|cloudflare|duckdns|tencentcloud|events-exec|jsonc|trojan'
```

---

## 多架构支持

该镜像自动构建支持：

- `linux/amd64`
- `linux/arm64`

---

## CI/CD

- **触发方式**：
  - push 到 `main`
  - 手动触发 workflow_dispatch
  - 每周一自动构建（cron 可调），并额外打 `nightly` 标签

- **镜像标签**：
  - `latest` → 当前官方 `caddy:latest` 基础上打包的最新构建  
  - `sha-<short>` → 对应仓库 commit 的快照，便于回滚  
  - `nightly` → 定时构建生成的镜像

---

## 开发建议

- 如 CI 网络拉取 Go 模块偶发变慢，可在 `Dockerfile` 的 builder 段临时添加：
  ```dockerfile
  ENV GOPROXY=https://goproxy.cn,direct
  ```
- 修改插件：编辑 `PLUGINS` 变量后 push 即可自动重建。

---

## 参考链接

- [Caddy 官方仓库](https://github.com/caddyserver/caddy)  
- [Caddy Docker 官方镜像](https://hub.docker.com/_/caddy)  
- [xcaddy](https://github.com/caddyserver/xcaddy)  
