FROM php:cli-alpine

# Copy script (Note: If you mount these in a container then don't forget to update/dump-autoload)
COPY ./ /app
WORKDIR /app

# Install composer
RUN ./install_composer.sh

# Install packages
RUN composer install

# Run tests via composer (See "script" directive in "composer.json")

ENTRYPOINT [ "composer", "test" ]
