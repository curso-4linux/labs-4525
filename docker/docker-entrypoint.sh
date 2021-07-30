#!/bin/sh

if [ "$MEMCACHED_HOST" -n ]; then
    # altera o php.ini
    sed -Ei 's/(session.save_handler).*/\1 = memcached/' /etc/php7/php.ini
    sed -Ei "s/;(session.save_path).*/\1 = \"$MEMCACHED_HOST\"/" /etc/php7/php.ini
fi

exec php -S 0.0.0.0:80
