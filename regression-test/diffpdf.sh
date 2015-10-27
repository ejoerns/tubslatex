#!/bin/bash

# usage: diffpdf.sh file_1.pdf file_2.pdf

# requirements:
# - ImageMagick
# - Poppler's pdftoppm and pdfinfo tools
#   (could be replaced with Ghostscript if speed is
#    not important - see commented commands below)

DIFFDIR="pdfdiff"   # directory to place diff images in
MAXPROCS=8          # number of parallel processes

RETCODE=0

pdf_file1=$1
pdf_file2=$2

function diff_page {
    # based on http://stackoverflow.com/a/33673440/438249
    pdf_file1=$1
    pdf_file2=$2
    page_number=$3
    page_index=$(($page_number - 1))

    # 2+x faster
    (cat $pdf_file1 | pdftoppm -f $page_number -singlefile -gray - | convert - miff:- ; \
     cat $pdf_file2 | pdftoppm -f $page_number -singlefile -gray - | convert - miff:- ) | \
    convert - \( -clone 0-1 -compose darken -composite \) \
            -channel RGB -combine $DIFFDIR/$page_number.jpg

    # 2x faster (breaks when using TIFF format instead of JPEG, and PNG is slow)
#    (pdftocairo -f $page_number -singlefile -jpeg $pdf_file1 -gray - | convert - miff:- ; \
#     pdftocairo -f $page_number -singlefile -jpeg $pdf_file2 -gray - | convert - miff:- ) | \
#    convert - \( -clone 0-1 -compose darken -composite \) \
#            -channel RGB -combine $DIFFDIR/$page_number.jpg

    # 1x (using Ghostscript for PDF to bitmap conversion)
#    convert -respect-parenthesis \
#            \( $pdf_file1[$page_index] -flatten -colorspace gray \) \
#            \( $pdf_file2[$page_index] -flatten -colorspace gray \) \
#            \( -clone 0-1 -compose darken -composite \) \
#            -channel RGB -combine $DIFFDIR/$page_number.jpg

#    compare $pdf_file1[$page_index] $pdf_file2[$page_index] \
#            -highlight-color blue pdfdiff/$page_number.png

    if (($? > 0)); then
        exit 1
    fi
    grayscale=$(convert pdfdiff/$page_number.jpg -colorspace HSL -channel g -separate +channel -format "%[fx:mean]" info:)
    if [ "$grayscale" != "0" ]; then
        echo "page $page_number: $grayscale"
        return 1
    else
        return 0
    fi 
}

function num_pages {
    pdf_file=$1

    pdfinfo $pdf_file | grep "Pages:" | awk '{print $2}'
}

function minimum {
    echo $(( $1 < $2 ? $1 : $2 ))
}

# guard agains accidental deletion of files in the root directory
if [ -z "$DIFFDIR" ]; then
    echo "DIFFDIR needs to be set!"
    exit 1
fi

pdf1_num_pages=$(num_pages $pdf_file1)
pdf2_num_pages=$(num_pages $pdf_file2)

min_pages=$(minimum $pdf1_num_pages $pdf2_num_pages)

if [ "$pdf1_num_pages" -ne "$pdf2_num_pages" ]; then
    echo "PDF files have different lengths ($pdf1_num_pages and $pdf2_num_pages)"
    RETCODE=15
fi

if [ -d "$DIFFDIR" ]; then
    rm -f $DIFFDIR/*
else
    mkdir $DIFFDIR
fi

for page_number in `seq 1 $min_pages`;
do
    diff_page $pdf_file1 $pdf_file2 $page_number || RETCODE=1
    # echo "$page_number \c"
    if [ "$(($page_number % $MAXPROCS))" -eq "0" ]; then
        wait
    fi
done
wait

exit $RETCODE
