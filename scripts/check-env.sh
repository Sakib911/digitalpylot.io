#!/bin/bash

check_environment() {
    if [ -z "$NODE_ENV" ]; then
        echo "NODE_ENV is not set. Defaulting to production."
        export NODE_ENV=production
    fi

    if [ -z "$PORT" ]; then
        echo "PORT is not set. Defaulting to 3000."
        export PORT=3000
    fi

    # Check for required directories
    for dir in "/var/www/digitalpylot.io" "/var/www/backups" "/var/log"; do
        if [ ! -d "$dir" ]; then
            echo "Creating directory: $dir"
            mkdir -p "$dir"
        fi
    done

    # Check for required permissions
    if [ ! -w "/var/www/digitalpylot.io" ]; then
        echo "Error: No write permission to /var/www/digitalpylot.io"
        exit 1
    fi
}