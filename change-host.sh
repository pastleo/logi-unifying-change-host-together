#!/bin/bash

base_path=$(dirname "$0")
host=$1

if ! [ -d "$base_path/python" ]; then
  echo "Please setup python venv first"
  exit 127
fi

"$base_path/python/bin/python" "$base_path/change-host.py" "$host"
