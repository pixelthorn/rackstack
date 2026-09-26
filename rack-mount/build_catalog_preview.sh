#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <scad_file>"
    exit 1
fi

SCAD_FILE="$1"
CONFIG="mini"

# skip "animate"
if $(basename "$SCAD_FILE" | grep -q "animate"); then
    echo "Skipping animation file: $SCAD_FILE"
    exit 0
fi 
if $(basename "$SCAD_FILE" | grep -q "entry_customizers"); then
    echo "Skipping entry customizers file: $SCAD_FILE"
    exit 0
fi 

dir=$(dirname "$SCAD_FILE")
if $(basename "$SCAD_FILE" | grep -q "entry"); then
    filename=$(basename "$dir" .scad)
else
    filename=$(basename "$SCAD_FILE" .scad)
fi

openscad \
    --colorscheme "Tomorrow Night" \
    --render \
    --imgsize 1920,1080 \
    --projection o \
    --viewall \
    --autocenter \
    -D "profileName=\"$CONFIG\"" \
    -D '$fn=64' \
    -o "$dir/$filename.png" \
    "$SCAD_FILE"

echo "Preview saved to $dir/$filename.png"
