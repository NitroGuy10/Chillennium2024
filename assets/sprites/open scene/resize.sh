#!/bin/bash

# Create the out/ folder if it doesn't exist
mkdir -p out

# Iterate through each .png file in the current folder
for file in *.PNG; do
    # Check if the file is a regular file
    if [ -f "$file" ]; then
        # Resize the image using ImageMagick and save the result to the out/ folder
        convert "$file" -resize 1300x992 "out/$file"
        echo "Resized $file"
    fi
done
