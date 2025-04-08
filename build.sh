#!/bin/bash

find docs/ -name '*.tex' | while read -r tex_file; do
    tex_dir=$(dirname "$tex_file")
    tex_base=$(basename "$tex_file" .tex)

    rel_path="${tex_dir#docs/}"
    output_dir="bin/${rel_path}"
    output_pdf="${output_dir}/${tex_base}.pdf"

    echo "📄 Compiling: $tex_file → $output_pdf"

    mkdir -p "$output_dir"

    pdflatex -output-directory="$tex_dir" "$tex_file" > /dev/null

    if [ -f "${tex_dir}/${tex_base}.pdf" ]; then
        mv "${tex_dir}/${tex_base}.pdf" "$output_pdf"
        echo "✅ Built: $output_pdf"
    else
        echo "⚠️ Failed: ${tex_file}"
    fi
done
