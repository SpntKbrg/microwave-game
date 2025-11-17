#!/usr/bin/env bash

main() {
    failed=0
    for filename in $(find . -name *.gd); do
        echo "$filename"
        godot --headless --check-only --script "$filename" || failed=1
    done
    return $failed
}

main
