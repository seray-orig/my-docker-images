#!/bin/bash
set -e

echo "=== Запуск игрового сервера ==="

if [ -z "$*" ]; then
    exec ./srcds_run -game garrysmod -console +maxplayers 88 +map gm_construct
else
    exec ./srcds_run "$@"
fi