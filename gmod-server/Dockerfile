FROM debian:stable-slim

ENV DEBIAN_FRONTEND=noninteractive
ENV LC_ALL=C.UTF-8 \
    LANG=C.UTF-8
ENV HOME=/home/container

RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        curl \
        ca-certificates \
        tar \
        lib32gcc-s1 \
        lib32stdc++6 \
        libcurl4t64:i386 && \
    echo "deb [arch=i386 trusted=yes] http://snapshot.debian.org/archive/debian/20240101T000000Z/ bookworm main" > /etc/apt/sources.list.d/snapshot.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        libtinfo5:i386 \
        libncurses5:i386 \
    && rm -rf /var/lib/apt/lists/* /etc/apt/sources.list.d/snapshot.list

WORKDIR /home/container

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 27015/udp
EXPOSE 27015/tcp

ENTRYPOINT ["/entrypoint.sh"]
