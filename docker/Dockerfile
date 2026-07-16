FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
ENV STEAMCMD_DIR=/opt/steamcmd
ENV SERVER_DIR=/opt/cs16/server

RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y \
        wget \
        curl \
        tar \
        unzip \
        ca-certificates \
        lib32gcc-s1 \
        libc6:i386 \
        libstdc++6:i386 \
        lib32stdc++6 && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /opt/cs16

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

EXPOSE 27015/tcp
EXPOSE 27015/udp

ENTRYPOINT ["/entrypoint.sh"]