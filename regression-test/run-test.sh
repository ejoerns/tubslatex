#!/bin/bash
#
# Arguments: Diff to commit ID
#-------------------------------------------------------------------------------

set -e

# commit id to diff to
DIFF_COMMIT=$1
CURRENT_COMMIT=$(git rev-parse HEAD)

# dir the temxf is in
TEXMF_DIR=../install/rawtree

OUT_DIR_CURRENT=out-current
OUT_DIR_BASE=out-base

TEXMF_CURRENT=texmf-current
TEXMF_BASE=texmf-base

if [ -z $1 ]; then
  echo "Run with 'run-test.sh COMMIT_ID'"
  exit
fi

# Create dirs for texmf files
mkdir -p texmf-base
mkdir -p texmf-current

# Make all new
make -BC $TEXMF_DIR/ font build-src

# Copy files to temporary texmf folder
cp -r $TEXMF_DIR/tex texmf-current/.
cp -r $TEXMF_DIR/doc texmf-current/.
cp -r $TEXMF_DIR/fonts texmf-current/.


# Checkout version to commit
git checkout $DIFF_COMMIT

# Make all new
make -BC $TEXMF_DIR/ font build-src

# Copy files to temporary texmf folder
cp -r $TEXMF_DIR/tex texmf-base/.
cp -r $TEXMF_DIR/doc texmf-base/.
cp -r $TEXMF_DIR/fonts texmf-base/.

# Create output directories
mkdir -p $OUT_DIR_CURRENT
mkdir -p $OUT_DIR_BASE

git checkout $CURRENT_COMMIT

# Generate all test files
for testfile in $(find test-documents -name *.tex); do
  TEXMFHOME=texmf-current:$(kpsewhich -var-value TEXMFHOME) pdflatex -output-directory $OUT_DIR_CURRENT $testfile;
  TEXMFHOME=texmf-base:$(kpsewhich -var-value TEXMFHOME) pdflatex -output-directory $OUT_DIR_BASE $testfile;

  ./pdfdiff.sh $OUT_DIR_CURRENT/$(basename $testfile .tex).pdf $OUT_DIR_BASE/$(basename $testfile .tex).pdf
done

