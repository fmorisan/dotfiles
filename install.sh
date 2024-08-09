#!/usr/bin/env bash
if ! command -v "stow"; then
    echo "stow not found in PATH, installing"
    if command -v "brew"; then
        echo "using brew"
        brew install stow
        brew install luarocks
    else if command -v "dnf"; then
        echo "using dnf"
        sudo dnf install stow luarocks
    else if command -v "apt"; then
        echo "using apt"
        sudo apt install stow luarocks
    else
        echo "unknown linux package manager, install stow and luarocks, then run this again"
        exit 1
    fi
fi

echo "Using stow to install symlinks into your .config"
stow $(ls -d */)
