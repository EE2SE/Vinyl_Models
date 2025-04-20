#!/bin/bash

set -eE  # Exit on error and propagate ERR trap
trap 'echo "Script failed at line $LINENO. Exiting."' ERR

# 1. Destroy existing virtual environment if it exists
if [ -d "venv" ]; then
    echo "Removing existing virtual environment..."
    rm -rf venv
fi

# 2. Create a new virtual environment
echo "Creating new virtual environment..."
python -m venv venv

# 3. Activate the virtual environment and install dependencies from pyproject.toml
echo "Activating virtual environment and installing dependencies..."
source venv/bin/activate
pip install --upgrade pip
pip install -e ".[dev]"

echo "Done. Virtual environment set up with dependencies from pyproject.toml."
