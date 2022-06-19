#!/usr/bin/env bash

export DIR_APP=laravel-app
export CONTAINER_APP=app
export WWWUSER=${WWWUSER:-$UID}
export WWWGROUP=${WWWGROUP:-$(id -g)}
export APP_USER=${WWWUSER}


function display_help {
    echo "Usage:";
    echo "  command [arguments]"
    echo "";
    echo "command:";
    echo "  [environment]";
    echo "      init                    Initialize develop environments";
    echo "      up   [option]           Execute docker-compose up";
    echo "      down [option]           Execute docker-compose down";
    echo "      clean-local             Cleanup local files(git clean -xn & rm -rf vendor)";
    echo "";
    echo "  [develop]";
    echo "      artisan [sub-command]   Execute artisan command on APP Container";
    echo "      tinker                  Execute php artisan tinekr on APP Container";
    echo "";
    echo "  [others]";
    echo "      help                    Display help for a command";
    echo "";
    exit 0;
}


cd ${DIR_APP}

if [ $# = 0 ]; then
    # 引数なしの場合, command helpを表示
    display_help

elif [ "$1" = "help" ]; then
    # command helpを表示
    display_help

elif [ $1 = "up" ]; then
  shift 1
  docker-compose up $@

elif [ $1 = "down" ]; then
  shift 1
  docker-compose down $@

elif [ $1 = "init" ]; then
    if [ ! -f .env ]; then
        cp .env.example .env
    fi
    docker-compose build
    docker-compose up -d
    docker-compose exec -u root ${CONTAINER_APP} bash -c "composer install && chown -R ${WWWUSER}:${WWWUSER} /var/www/html/vendor"
    docker-compose down
    docker-compose up -d
    echo "waiting for mysql 10sec...";
    sleep 10
    docker-compose exec -u ${APP_USER} ${CONTAINER_APP} php artisan migrate:fresh --seed
    echo "init finish!";

elif [ $1 == "clean-local" ]; then
    rm -rf vendor
    cd .. && git clean -xf

elif [ $1 == "artisan" ]; then
  shift 1
  docker-compose exec -u ${APP_USER} ${CONTAINER_APP} php artisan $@

elif [ $1 == "tinker" ]; then
  docker-compose exec -u ${APP_USER} ${CONTAINER_APP} php artisan tinker

elif [ $# -ge 1 ]; then
  # 未指定のパラメータの場合、docker-copmoseコマンドをそのまま呼び出す
  docker-compose $@
fi
