#!/bin/bash

# This script demonstrates a solution to the race condition bug.

# Create two files
touch file1.txt file2.txt

# Function to increment a counter in a file using flock to avoid race condition
increment_counter() {
  local filename=$1
  flock -n "$filename" || exit 1 # Obtain an exclusive lock on file
  local counter=$(cat "$filename")
  if [[ -z "$counter" ]]; then
    counter=0
  fi
  counter=$((counter + 1))
  echo "$counter" > "$filename"
  flock -u "$filename" # Unlock the file
}

# Run increment_counter in two parallel processes
increment_counter file1.txt &
increment_counter file1.txt &
wait

# Expected output: counter incremented twice reliably.
cat file1.txt