#!/bin/bash

if [ -z "$1" ]; then
    echo "Error: Please provide the path to the C source file."
    echo "Usage: $0 \"path/to/your/source.c\""
    exit 1
fi

SOURCE_FILE="$1"

if [ ! -f "$SOURCE_FILE" ]; then
    echo "Error: Source file not found at '$SOURCE_FILE'"
    exit 1
fi

DIR_NAME=$(dirname "$SOURCE_FILE")
BASE_NAME=$(basename "$SOURCE_FILE" .c)
EXECUTABLE="${DIR_NAME}/${BASE_NAME}"

echo "Compiling $SOURCE_FILE..."
gcc "$SOURCE_FILE" -o "$EXECUTABLE"
COMPILATION_EXIT_CODE=$?

if [ $COMPILATION_EXIT_CODE -eq 0 ]; then
    echo "Compilation successful. Running executable..."
    "./$EXECUTABLE"
    RUN_EXIT_CODE=$?

    rm -f "$EXECUTABLE"
    echo "Cleaned up: Deleted '$EXECUTABLE'."
    exit $RUN_EXIT_CODE
else
    echo "Compilation FAILED. Check the errors above."
    rm -f "$EXECUTABLE"
    exit 1
fi