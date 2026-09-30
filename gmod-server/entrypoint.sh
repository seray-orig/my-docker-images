#!/bin/bash
set -e

SERVER_NAME="${SERVER_NAME:-server_default}"
STEAMCMD_DIR="/opt/steamcmd"
SERVER_DIR="/home/$SERVER_NAME"
UPDATE_SERVER="${UPDATE_SERVER:-false}"

mkdir -p "$SERVER_DIR"

# Проверяем флаг обновления из переменной окружения
if [ "$UPDATE_SERVER" = "true" ]; then
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