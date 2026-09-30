FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive
ENV LC_ALL=C.UTF-8 \
    LANG=C.UTF-8 \
    HOME=/server

WORKDIR /server

RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        lib32gcc-s1 \
        lib32stdc++6 \
        libtinfo5:i386 \
        libncurses5:i386 \
    && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 27015/udp
EXPOSE 27015/tcp

ENTRYPOINT ["/entrypoint.sh"]