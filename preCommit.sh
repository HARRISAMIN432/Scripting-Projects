#!/bin/sh

# Run make to build the paper
echo "Running make paper.pdf..."
if ! make paper.pdf; then
    echo "❌ Build failed. Commit aborted."
    exit 1
fi

echo "✅ Build succeeded. Proceeding with commit."

