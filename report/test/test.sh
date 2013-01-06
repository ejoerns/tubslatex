#!/bin/bash

set -e

docclasses=( tubsartcl tubsreprt tubsbook )
titlestyles=( plain image imagetext )
backstyles=( plain addressinfo trisec )

jobname=$1

idx=0
back=0
for i in ${titlestyles[@]}; do
	for j in ${docclasses[@]}; do
		cat $jobname.tex |
		sed "s/#TITLESTYLE#/$i/g" |
		sed "s/#DOCCLASS#/$j/g" |
		sed "s/#BACKSTYLE#/${backstyles[back]}/g" |
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
