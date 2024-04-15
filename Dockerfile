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
    # Arch specific packages - GoLang
    wget https://go.dev/dl/go1.22.0.linux-${arch}.tar.gz && tar -xzf go1.22.0.linux-${arch}.tar.gz --directory /usr/local/ && rm go1.22.0.linux-${arch}.tar.gz && \
    # Dev and util packages
    apt-get install -y clang llvm libelf-dev libpcap-dev vim net-tools tshark \
    elfutils dwarves git libbsd-dev bridge-utils wget unzip build-essential traceroute \
    bison flex sudo iproute2 pkg-config tcpdump iputils-ping curl socat netcat

ENTRYPOINT ["/bin/bash"]
