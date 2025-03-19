#!/bin/bash

# Directory to search
SEARCH_DIR="/path/to/search"

# Number of large files to display
TOP_N=10

# Find and display the largest files
echo "Top $TOP_N largest files in $SEARCH_DIR:"
du -ah "$SEARCH_DIR" 2>/dev/null | sort -rh | head -n "$TOP_N"