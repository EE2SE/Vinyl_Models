#!/bin/bash

VENV_DIR="venv"
PYPROJECT_FILE="pyproject.toml"

if [ ! -f "$PYPROJECT_FILE" ]; then
    echo "❌ No pyproject.toml found in the current directory."
    exit 1
fi

# Check if virtual environment already exists
if [ -d "$VENV_DIR" ]; then
    echo "✅ Virtual environment already exists at ./$VENV_DIR"
else
    echo "🚀 Creating virtual environment..."
    python3 -m venv "$VENV_DIR"

    if [ $? -eq 0 ]; then
        echo "✅ Virtual environment created successfully at ./$VENV_DIR"
    else
        echo "❌ Failed to create virtual environment."
        exit 1
    fi

    # Activate venv and install dependencies
    echo "📦 Installing dependencies from pyproject.toml..."
    source "$VENV_DIR/bin/activate"

    # Upgrade pip and install dependencies using requirements from pyproject.toml
    pip install --upgrade pip

    # Extract dependencies
    DEPS=$(python3 - <<EOF
import tomllib
with open("$PYPROJECT_FILE", "rb") as f:
    deps = tomllib.load(f)["project"].get("dependencies", [])
    print(" ".join(deps))
EOF
)

    if [ -n "$DEPS" ]; then
        pip install $DEPS
        echo "✅ Dependencies installed: $DEPS"
    else
        echo "ℹ️ No dependencies found in pyproject.toml."
    fi
    source "$VENV_DIR/bin/activate"
fi

