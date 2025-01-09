#!/bin/bash

source "$(dirname "$0")/utils.sh"

install_node() {
    echo "Installing Node.js and npm..."
    
    # Clean up any stale lock files
    cleanup_package_locks
    
    # Try to install Node.js from NodeSource
    if curl -fsSL https://rpm.nodesource.com/setup_18.x | bash - ; then
        install_packages nodejs
        return 0
    fi
    
    # Fallback: Try installing from default repos
    if install_packages nodejs npm; then
        return 0
    fi
    
    echo "Failed to install Node.js through package managers"
    return 1
}

build_app() {
    echo "Checking for Node.js and npm..."
    
    # Check if Node.js is installed
    if ! command -v node &> /dev/null; then
        if ! install_node; then
            echo "Failed to install Node.js. Deployment cannot continue."
            exit 1
        fi
    fi

    # Ensure we're in the project directory
    cd "${DEPLOY_PATH}/current" || exit 1

    echo "Installing dependencies..."
    if ! npm ci --production; then
        echo "Failed to install npm dependencies"
        exit 1
    fi

    echo "Building application..."
    if ! npm run build; then
        echo "Build failed!"
        exit 1
    fi

    echo "Build completed successfully!"
}