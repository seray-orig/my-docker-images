#!/bin/bash
set -e

#docker run --rm \
#  -v /ваш_путь_где_будет_сервер:/server \
#  ghcr.io/steamcmd/steamcmd:debian-bookworm \
#  +force_install_dir /server +login anonymous +app_update 4020 validate +quit

# Все файлы уже скачаны временным контейнером SteamCMD
echo "=== Запуск игрового сервера ==="

if [ -z "$*" ]; then
    exec ./srcds_run -game garrysmod -console +maxplayers 16 +map gm_construct
else
    exec ./srcds_run "$@"
fi