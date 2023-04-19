#!/bin/bash
set -e

cd ~/colouring-core/app
echo "Installing all dependencies..."
npm install
echo "Cleaning build directory..."
npm run clean
echo "Running production build..."
npm run build -- --noninteractive
