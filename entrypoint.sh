#!/usr/bin/env bash

echo "$(ip r | grep default | grep -o '[0-9]\+.[0-9]\+.[0-9]\+.[0-9]\+') localhost" >> /etc/hosts

php-fpm