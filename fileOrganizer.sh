#!/bin/bash

TARGET_DIR=${1:-.}

mkdir -p "$TARGET_DIR"/{Images,Docs,Archives,Others}

for files in "$TARGET_DIR"/*; do
	[ -f "$file" ] || continue
	case "${file##*.}" in
        jpg|jpeg|png|gif)
            mv "$file" "$TARGET_DIR/Images/"
            ;;
        pdf|doc|docx|txt)
            mv "$file" "$TARGET_DIR/Docs/"
            ;;
        zip|tar|gz|rar|7z)
            mv "$file" "$TARGET_DIR/Archives/"
            ;;
        *)
            mv "$file" "$TARGET_DIR/Others/"
            ;;
   	 esac
done
