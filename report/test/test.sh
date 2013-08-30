#!/bin/bash

set -e

setidx=0
testset() {
	# first item
	echo $1
	# other items
	echo ${@:2}
	setidx=`expr $setidx+1`
}

# load config file and set jobname
. $1.cfg
jobname=$1

exit 0

idx=0
back=0
for i in ${TITLESTYLE[@]}; do
	for j in ${DOCCLASS[@]}; do	
		cat $jobname.tex |
		sed "s/#TITLESTYLE#/$i/g" |
		sed "s/#DOCCLASS#/$j/g" |
		sed "s/#BACKSTYLE#/${BACKSTYLE[back]}/g" |
		pdflatex -jobname $jobname$i$j

		echo "
		\documentclass{scrartcl}
		\begin{document}
		\centering\sffamily\Huge
			$jobname\_$i\_$j
		\end{document}" | pdflatex -jobname fillpage$i$j
		catlist[idx]=fillpage$i$j.pdf
		catlist[idx+1]=$jobname$i$j.pdf
		idx=`expr $idx+2`
	done
	back=`expr $back+1`
done

echo "merging..."
pdftk ${catlist[@]} cat output $jobname.pdf

echo "cleaning..."
rm -f ${catlist[@]}
rm -f *.aux *.log

echo "done."
