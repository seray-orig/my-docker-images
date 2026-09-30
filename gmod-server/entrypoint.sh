#!/bin/bash
set -e

STEAMCMD_DIR="/home/steamcmd"
SERVER_DIR="/home/server"

mkdir -p "$STEAMCMD_DIR" "$SERVER_DIR"

if [ ! -f "$STEAMCMD_DIR/steamcmd.sh" ]; then
    echo "=== Скачивание и установка SteamCMD ==="
    cd "$STEAMCMD_DIR"
    curl -sSL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar -xz
fi

DO_UPDATE=false
CLEANED_ARGS=()

for arg in "$@"; do
    if [ "$arg" = "-update" ]; then
        DO_UPDATE=true
    else
        CLEANED_ARGS+=("$arg")
    fi
done

if [ "$DO_UPDATE" = true ]; then
    echo "=== Проверка обновлений/установка Garry's Mod ==="
    "$STEAMCMD_DIR/steamcmd.sh" +force_install_dir "$SERVER_DIR" +login anonymous +app_update 4020 validate +quit || true
else
    echo "=== Обновление Garry's Mod пропущено ==="
fi

echo "=== Запуск игрового сервера ==="
cd "$SERVER_DIR"

if [ -z "$*" ]; then
    # Если аргументы не переданы — дефолтный запуск
    exec ./srcds_run -game garrysmod -console +maxplayers 16 +map gm_construct
else
    # Передаём все аргументы, указанные в docker run
    exec ./srcds_run "$@"
fi
