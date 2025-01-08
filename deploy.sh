#!/bin/bash

# Configuration
APP_NAME="digitalpylot-maintenance"
DEPLOY_PATH="/var/www/digitalpylot.io"
BACKUP_PATH="/var/www/backups"
LOG_FILE="/var/log/deployments.log"

# Source the component scripts
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$DIR/scripts/check-env.sh"
source "$DIR/scripts/build.sh"
source "$DIR/scripts/start.sh"

# Logging function
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

# Create necessary directories
mkdir -p "$DEPLOY_PATH" "$BACKUP_PATH" "$(dirname "$LOG_FILE")"

log "Starting deployment process for $APP_NAME..."

# Create backup
BACKUP_NAME="$APP_NAME-$(date '+%Y%m%d_%H%M%S')"
if [ -d "$DEPLOY_PATH/current" ]; then
    log "Creating backup of current deployment..."
    tar -czf "$BACKUP_PATH/$BACKUP_NAME.tar.gz" -C "$DEPLOY_PATH" current
fi

# Run deployment steps
check_environment
build_app

# Deploy new version
log "Deploying new version..."
if [ -d "$DEPLOY_PATH/current" ]; then
    mv "$DEPLOY_PATH/current" "$DEPLOY_PATH/previous"
fi

mkdir -p "$DEPLOY_PATH/current"
cp -r .next package.json package-lock.json public "$DEPLOY_PATH/current/"

# Start the application
cd "$DEPLOY_PATH/current"
start_app

log "Deployment completed successfully!"