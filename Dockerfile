FROM php:cli-alpine

# Install composer
RUN \
    EXPECTED_SIGNATURE="$(wget -q -O - https://composer.github.io/installer.sig)"; \
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"; \
    ACTUAL_SIGNATURE="$(php -r "echo hash_file('sha384', 'composer-setup.php');")"; \
    [ "$EXPECTED_SIGNATURE" != "$ACTUAL_SIGNATURE" ] && { >&2 echo 'ERROR: Invalid installer signature'; exit 1; }; \
    php composer-setup.php --install-dir=$(dirname $(which php)) --filename=composer && \
    composer --version && \
    which composer && \
    rm composer-setup.php

# Copy script (Note: If you mount these in a container then don't forget to update/dump-autoload)
COPY ./ /app
WORKDIR /app

# Install packages
RUN composer install

# Run tests via composer (See "script" directive in "composer.json")

ENTRYPOINT [ "composer", "test" ]
