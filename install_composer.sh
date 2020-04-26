#!/bin/sh

EXPECTED_SIGNATURE="$(wget -q -O - https://composer.github.io/installer.sig)"
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
ACTUAL_SIGNATURE="$(php -r "echo hash_file('sha384', 'composer-setup.php');")"
[ "$EXPECTED_SIGNATURE" != "$ACTUAL_SIGNATURE" ] && {
    >&2 echo 'ERROR: Invalid installer signature'; exit 1;
}

php composer-setup.php --install-dir=$(dirname $(which php)) --filename=composer && \
composer --version && \
which composer && \
rm composer-setup.php
