FROM debian:bookworm-slim

RUN dpkg --add-architecture i386 && \
    apt-get update && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        lib32gcc-s1 \
    && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENV HOME=/steamcmd
WORKDIR /steamcmd

RUN curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf -
RUN ./steamcmd.sh +app_info_update 1 +app_info_request 4020 +quit

RUN chmod -R 777 /steamcmd

ENTRYPOINT ["/entrypoint.sh"]