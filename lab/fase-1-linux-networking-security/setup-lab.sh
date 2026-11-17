#!/bin/bash
# Setup script to initialize the lab workspace

echo "Setting up the lab environment..."
rm -rf "$HOME/app-deploy"
mkdir -p "$HOME/app-deploy"

echo "Lab workspace initialized at: $HOME/app-deploy"
echo "Read the instructions and run 'bash grade-lab.sh' anytime to check your progress!"
