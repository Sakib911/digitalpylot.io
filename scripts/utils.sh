#!/bin/bash

# Utility functions for deployment

# Check package manager and install packages
install_packages() {
    local packages=("$@")
    
    if command -v dnf &> /dev/null; then
        # DNF is available (newer CentOS/RHEL)
        dnf install -y "${packages[@]}"
    elif command -v yum &> /dev/null; then
        # Try to clean yum first
        yum clean all
        rm -rf /var/cache/yum
        # Install with yum
        yum install -y "${packages[@]}"
    else
        echo "No supported package manager found"
        return 1
    fi
}

# Check if a process is actually running
check_process() {
    local pid=$1
    if [ -f "/proc/$pid/status" ]; then
        return 0
    fi
    return 1
}

# Clean up stale lock files
cleanup_package_locks() {
    if [ -f /var/run/yum.pid ]; then
        local pid=$(cat /var/run/yum.pid)
        if ! check_process "$pid"; then
            echo "Removing stale yum lock file..."
            rm -f /var/run/yum.pid
        fi
    fi
}