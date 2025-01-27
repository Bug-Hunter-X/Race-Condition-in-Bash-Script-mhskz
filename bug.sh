#!/bin/bash

# This script demonstrates a race condition bug.

# Create two files
touch file1.txt file2.txt

# Function to increment a counter in a file
increment_counter() {
  local filename=$1
  local counter=$(cat "$filename")
  if [[ -z "$counter" ]]; then
    counter=0
  fi
  counter=$((counter + 1))
  echo "$counter" > "$filename"
}

# Run increment_counter in two parallel processes
increment_counter file1.txt &
increment_counter file1.txt &
wait

# Expected output: counter incremented twice but that is not happening always.
cat file1.txt