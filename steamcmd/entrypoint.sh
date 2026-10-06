#!/bin/bash

HOST_UID=$(stat -c '%u' /server)
HOST_GID=$(stat -c '%g' /server)

groupmod -o -g "$HOST_GID" steamcmd
usermod -o -u "$HOST_UID" steamcmd

while true; do
    echo -e "\e[36m=== Установка/Обновление сервера ===\e[0m"

    exec gosu steamcmd /steamcmd/steamcmd.sh "$@"
    STATUS=$?

    # Код 0 - стимцмд успешно справился.
    if [ $STATUS -eq 0 ]; then
        echo -e "\e[32m=== Действие успешно завершено! ===\e[0m"
        break

    # Код 8 - конкретно ошибка (Missing configuration).
    elif [ $STATUS -eq 8 ]; then
        echo -e "\e[32m=== Это тупорылая ошибка \e[1;32m(Missing configuration)\e[22m. ==="
        echo -e "=== Нужно повторить, \e[1;32mне закрывайте SteamCMD!\e[22m Всё будет хорошо :D ===\e[0m"
        sleep 5

    else
        echo -e "\e[31m=== Ошибка! ===\e[0m"
        exit $STATUS
    fi
done
