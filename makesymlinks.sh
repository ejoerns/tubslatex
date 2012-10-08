#/bin/bash
# Creates symlinks to local texmf for developing

mkdir -p ~/texmf/tex/latex
ln -s $(pwd)/cd-base ~/texmf/tex/latex/cd-base
ln -s $(pwd)/beamer/src ~/texmf/tex/latex/beamer
ln -s $(pwd)/report/src/build ~/texmf/tex/latex/report
ln -s $(pwd)/letter/src ~/texmf/tex/latex/letter
# Nexus
ln -s $(pwd)/nexus ~/texmf/tex/latex/nexus

# Update local ls-R
mktexlsr ~/texmf
