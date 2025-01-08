#!/bin/bash

build_app() {
  echo "Installing dependencies..."
  npm install --production

  echo "Building application..."
  npm run build

  if [ $? -ne 0 ]; then
    echo "Build failed!"
    exit 1
  fi
}