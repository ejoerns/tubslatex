#!/bin/sh

#set -e

LOGFILE=$(mktemp)
if [ $? -ne 0 ]; then
  echo "Creating log file failed."
  exit 1
fi

# generate 
cd src
mkdir -p build
for i in $(find . -name '*.tex'); do
  echo -n "Generating $i..."
  latexmk -pdf -interaction=batchmode -shell-escape -verbose -outdir=../build $i >> $LOGFILE 2>&1
  #pdflatex -interaction batchmode -shell-escape -output-directory ../build $i >> $LOGFILE 2>&1
  if [ $? -ne 0 ]; then
    echo "failed."
  else
    echo "done."
  fi
done
cd ..

# compare

ERROR=0
for i in $(find src/ -name '*.tex'); do
  echo -n "Checking $i: "
  #comparepdf -ca build/$(basename $i .tex).pdf ref/$(basename $i .tex).pdf >> $LOGFILE 2>&1
  ./diffpdf.sh build/$(basename $i .tex).pdf ref/$(basename $i .tex).pdf >> $LOGFILE 2>&1
  RESULT=$?
  if [ $RESULT -ne 0 ]; then
    echo "[ERROR] ($RESULT)"
    ERROR=1
  else
    echo "[OK]"
  fi
done

echo "Log dumped to $LOGFILE"

#if [ $ERROR -ne 0 ]; then
#  echo "Test failed, see result:"
#  cat $LOGFILE
#fi

exit $ERROR
