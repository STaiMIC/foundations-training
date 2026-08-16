#!/usr/bin/env bash
set -euo pipefail

echo "Setting up foundations-training environment..."

# Install Java (required for Nextflow)
sudo apt-get update -qq
sudo apt-get install -y -qq openjdk-17-jdk

# Install Nextflow
curl -s https://get.nextflow.io | bash
sudo mv nextflow /usr/local/bin/

# Confirm versions
java -version
nextflow -version

echo "Setup complete! You are ready to start: see GETTING_STARTED.md"