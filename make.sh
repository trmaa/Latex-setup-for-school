#!/bin/bash

build_file() {
    local file_path="$1"
    local output_dir="$2"
    local file_name=$(basename "$file_path" .tex)
    
    echo -e "\033[38;2;150;200;0mCreating $file_name.pdf\033[0m"	

    mkdir -p "$output_dir"
    rm -rf "$output_dir/*"
    
	(
		cd "$(dirname "$file_path")" || exit 1
		pdflatex -interaction=nonstopmode -output-directory="../../$output_dir" "$(basename "$file_path")"
	)
	(
		cd "$output_dir"
		#rm -f -- *.aux *.log *.out *.toc *.nav *.snm *.vrb
	)
}

if [ $# -ne 2 ]; then
    echo "Usage: $0 <source_directory> <output_subdirectory>"
    exit 1
fi

src_dir="$1"
output_subdir="$2"

find "$src_dir" -name "*.tex" | while read -r f; do
    build_file "$f" "pdf/$output_subdir"
done
