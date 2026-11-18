#!/bin/bash
# Setup script to initialize the Lab 1 workspace

echo "Setting up Lab 1 environment..."
rm -rf "$HOME/app-deploy"
mkdir -p "$HOME/app-deploy"

echo "Lab 1 workspace initialized at: $HOME/app-deploy"
echo "Read README.md and run 'bash grade-lab.sh' anytime to check your progress!"
