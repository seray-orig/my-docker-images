#!/bin/bash
set -e

STEAMCMD_DIR="/home/container/steamcmd"
SERVER_DIR="/home/container/garrysmod"

mkdir -p "$STEAMCMD_DIR" "$SERVER_DIR"

if [ ! -f "$STEAMCMD_DIR/steamcmd.sh" ]; then
    echo "=== SteamCMD не найден. Скачивание и установка... ==="
    cd "$STEAMCMD_DIR"
    curl -sSL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar -xz
fi

echo "=== Проверка обновлений Garry's Mod... ==="
"$STEAMCMD_DIR/steamcmd.sh" +force_install_dir "$SERVER_DIR" +login anonymous +app_update 4020 validate +quit || true

echo "=== Запуск игрового сервера... ==="
cd "$SERVER_DIR"

if [ -z "$*" ]; then
    # Если аргументы не переданы — дефолтный запуск
    exec ./srcds_run -game garrysmod -console +maxplayers 16 +map gm_construct
else
    # Передаём все аргументы, указанные в docker run
    exec ./srcds_run "$@"
fi
