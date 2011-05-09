#!/usr/bin/bash 
export PSTILL_PATH=/usr/share/pstill_dist
OUTDIR=pdf
mkdir -p $OUTDIR
for i in *.eps; do pstill -M default -v -o $OUTDIR/$(basename $i .eps).pdf $i; done