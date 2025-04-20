#!/bin/bash

# 1. Destroy existing virtual environment if it exists
if [ -d "venv" ]; then
    echo "Enabling virtual env..."
    source venv/bin/activate
else
    echo "No virtual env found. Running setup..."
    source setupEnv.sh
fi

echo "Stopping supabase engine..."
supabase stop

echo "Removing previously created volumes..."
docker volume rm supabase_db_VinylDB

echo "Starting supabase engine and seeding..."
supabase start

supabase db reset

echo "Running tests..."
pytest tests