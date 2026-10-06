#!/bin/bash
set -e

HOST_UID=$(stat -c '%u' /server)
HOST_GID=$(stat -c '%g' /server)

groupmod -o -g "$HOST_GID" server
usermod -o -u "$HOST_UID" server

echo -e "\e[1;33m=== Запуск игрового сервера ===\e[0m"
exec gosu server ./srcds_run "$@"
