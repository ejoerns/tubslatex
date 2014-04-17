#!/bin/bash

set -e

PDFA=$1
PDFB=$2

if [ -z $1 ] || [ -z $2 ]; then
  echo "Usage: mypdfdiff file1.pdf file2.pdf"
  exit
fi

TMPDIR=tmp

mkdir $TMPDIR

pdftk $PDFA burst output $TMPDIR/pdfa%03d.pdf
pdftk $PDFB burst output $TMPDIR/pdfb%03d.pdf


echo -n "Comparing $PDFA with $PDFB"
for file in $(find $TMPDIR -name pdfa\*); do
  SRCA=$file
  SRCB=$(echo $file | sed 's/pdfa/pdfb/g')
  DST=$(echo $file | sed 's/pdfa/out/g')
  compare -density 300 -compose src $SRCA $SRCB $DST > /dev/null 2>&1
  echo -n "."
done
echo "done."

pdftk $TMPDIR/out* cat output $TMPDIR/all.pdf
mv $TMPDIR/all.pdf diff-of-$(basename $PDFA)-$(basename $PDFB).pdf

rm -r tmp
