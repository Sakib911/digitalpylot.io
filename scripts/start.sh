#!/bin/bash

start_app() {
    echo "Starting Next.js application..."
    
    # Check if PM2 is installed globally
    if ! command -v pm2 &> /dev/null; then
        echo "Installing PM2..."
        npm install -g pm2
    fi

    # Stop existing instance if running
    pm2 stop digitalpylot-maintenance &> /dev/null || true
    pm2 delete digitalpylot-maintenance &> /dev/null || true

    # Start new instance with specific port
    PORT=3000 pm2 start npm --name "digitalpylot-maintenance" -- start

    if [ $? -ne 0 ]; then
        echo "Failed to start application!"
        exit 1
    fi

    # Save PM2 process list
    pm2 save

    echo "Application started successfully!"
}