FROM rust:1-slim-buster

RUN apt-get update \
  && export DEBIAN_FRONTEND=noninteractive \
  && apt-get install -y \
    cmake pkg-config libssl-dev git \
    build-essential clang libclang-dev \
    gcc curl vim

RUN rustup install nightly \
  && rustup target add wasm32-unknown-unknown --toolchain nightly \
  && rustup component add rust-src --toolchain nightly

ARG CANVAS_NODE_VERSION="0.1.4"

RUN cargo install canvas-node \
  --git https://github.com/paritytech/canvas-node.git \
  --tag v${CANVAS_NODE_VERSION} \
  --force --locked
    
ENTRYPOINT ["canvas"]
CMD ["--dev", "--tmp", "--no-prometheus", "--rpc-external", "--ws-external"]

LABEL \
  org.label-schema.name="Canvas Node" \
  org.label-schema.description="Node implementation for Canvas, a Substrate chain for smart contracts." \
  org.label-schema.vcs-url="https://github.com/elkozmon/canvas-node-docker" \
  org.label-schema.docker.cmd="docker run -d -p 9944:9944 --name canvas-node --restart unless-stopped elkozmon/canvas-node:latest"