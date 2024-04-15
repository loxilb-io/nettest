# Download base image ubuntu 22.04 for build
FROM ubuntu:22.04

# Disable Prompt During Packages Installation
ARG DEBIAN_FRONTEND=noninteractive

# Env variables
ENV PATH="${PATH}:/usr/local/go/bin"

# Install network testing helper packages
RUN \
    # Update Ubuntu Software repository
    apt-get update && apt-get install -y wget && \
    arch=$(arch | sed s/aarch64/arm64/ | sed s/x86_64/amd64/) && \
    apt-get install -y vim net-tools tshark bridge-utils unzip \
    unzip traceroute sudo iproute2 pkg-config tcpdump \
    iputils-ping curl socat netcat

ENTRYPOINT ["/bin/bash"]
