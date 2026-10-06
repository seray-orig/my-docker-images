FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive
ENV LC_ALL=C.UTF-8 \
    LANG=C.UTF-8 \
    HOME=/steamcmd

RUN useradd -d $HOME -s /bin/false steamcmd

WORKDIR /steamcmd

RUN dpkg --add-architecture i386 && \
    apt-get update && apt-get install -y --no-install-recommends \
        gosu \
        ca-certificates \
        curl \
        lib32gcc-s1 \
    && rm -rf /var/lib/apt/lists/*

RUN gosu nobody true

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

RUN curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf -
RUN ./steamcmd.sh +app_info_update 1 +app_info_request 4020 +quit

RUN chmod -R 777 /steamcmd

ENTRYPOINT ["/entrypoint.sh"]