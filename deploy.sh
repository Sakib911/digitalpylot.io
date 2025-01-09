#!/bin/bash

# Configuration
APP_NAME="digitalpylot-maintenance"
DEPLOY_PATH="/var/www/digitalpylot.io"
BACKUP_PATH="/var/www/backups"
LOG_FILE="/var/log/deployments.log"

# Source the component scripts
DIR="$(dirname "${BASH_SOURCE[0]}")"
source "$DIR/scripts/utils.sh"
source "$DIR/scripts/check-env.sh"
source "$DIR/scripts/build.sh"
source "$DIR/scripts/start.sh"

# Logging function
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

# Error handling
set -e
trap 'log "Error: Deployment failed on line $LINENO"' ERR

# Create necessary directories
mkdir -p "$DEPLOY_PATH" "$BACKUP_PATH" "$(dirname "$LOG_FILE")"

log "Starting deployment process for $APP_NAME..."

# Copy project files first
log "Copying project files..."
rm -rf "$DEPLOY_PATH/current"
mkdir -p "$DEPLOY_PATH/current"
cp -r . "$DEPLOY_PATH/current/"

# Create backup of the previous deployment if it exists
BACKUP_NAME="$APP_NAME-$(date '+%Y%m%d_%H%M%S')"
if [ -d "$DEPLOY_PATH/previous" ]; then
    log "Creating backup of previous deployment..."
    tar -czf "$BACKUP_PATH/$BACKUP_NAME.tar.gz" -C "$DEPLOY_PATH" previous
fi

# Run deployment steps
check_environment
build_app

# Start the application
cd "$DEPLOY_PATH/current"
start_app

log "Deployment completed successfully!"