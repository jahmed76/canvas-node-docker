# Canvas Node in Docker
Dockerfile for Parity's Canvas Node, a Substrate chain for smart contracts.

## Quick start
```sh
docker run \
  -d -p 9944:9944 \
  --name canvas-node \
  --restart unless-stopped \
  elkozmon/canvas-node:latest
```
