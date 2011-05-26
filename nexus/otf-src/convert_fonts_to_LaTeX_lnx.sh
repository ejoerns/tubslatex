## Generate NexusPro LaTeX fonts, move them to right location and make them known to the LaTeX system (pdflatex)
# Serif
otftotfm --no-updmap --vendor=Fontshop --name=NexusProSerif-Regular --warn-missing --verbose --encoding=texnansx --feature=kern --feature=liga --feature=lnum --map-file=NexusProSerif.map NexusSerifPro-Regular.otf 
otftotfm --no-updmap --vendor=Fontshop --name=NexusProSerif-Italic --warn-missing --verbose --encoding=texnansx --feature=kern --feature=liga --feature=lnum --map-file=NexusProSerif.map NexusSerifPro-Italic.otf 
otftotfm --no-updmap --vendor=Fontshop --name=NexusProSerif-SmallCaps --warn-missing --verbose --encoding=texnansx --feature=kern --feature=liga --feature=lnum --feature=smcp --map-file=NexusProSerif.map NexusSerifPro-Regular.otf 
otftotfm --no-updmap --vendor=Fontshop --name=NexusProSerif-Slanted --slant=.167 --warn-missing --verbose --encoding=texnansx --feature=kern --feature=liga --feature=lnum --map-file=NexusProSerif.map NexusSerifPro-Regular.otf 

otftotfm --no-updmap --vendor=Fontshop --name=NexusProSerif-Bold-Regular --warn-missing --verbose --encoding=texnansx --feature=kern --feature=liga --feature=lnum --map-file=NexusProSerif.map NexusSerifPro-Bold.otf 
otftotfm --no-updmap --vendor=Fontshop --name=NexusProSerif-Bold-Italic --warn-missing --verbose --encoding=texnansx --feature=kern --feature=liga --feature=lnum --map-file=NexusProSerif.map NexusSerifPro-BoldItalic.otf 
otftotfm --no-updmap --vendor=Fontshop --name=NexusProSerif-Bold-SmallCaps --warn-missing --verbose --encoding=texnansx --feature=kern --feature=liga --feature=lnum --feature=smcp --map-file=NexusProSerif.map NexusSerifPro-Bold.otf 
otftotfm --no-updmap --vendor=Fontshop --name=NexusProSerif-Bold-Slanted --slant=.167 --warn-missing --verbose --encoding=texnansx --feature=kern --feature=liga --feature=lnum --map-file=NexusProSerif.map NexusSerifPro-Bold.otf 

# Sans Serif
otftotfm --no-updmap --vendor=Fontshop --name=NexusProSans-Regular --verbose --encoding=texnansx --feature=kern --feature=liga --feature=lnum --map-file=NexusProSans.map NexusSansPro-Regular.otf 
otftotfm --no-updmap --vendor=Fontshop --name=NexusProSans-Italic --verbose --encoding=texnansx --feature=kern --feature=liga --feature=lnum --map-file=NexusProSans.map NexusSansPro-Italic.otf 
otftotfm --no-updmap --vendor=Fontshop --name=NexusProSans-SmallCaps --verbose --encoding=texnansx --feature=kern --feature=liga --feature=lnum --feature=smcp --map-file=NexusProSans.map NexusSansPro-Regular.otf 
otftotfm --no-updmap --vendor=Fontshop --name=NexusProSans-Slanted --slant=.167 --verbose --encoding=texnansx --feature=kern --feature=liga --feature=lnum --map-file=NexusProSans.map NexusSansPro-Regular.otf 

otftotfm --no-updmap --vendor=Fontshop --name=NexusProSans-Bold-Regular --verbose --encoding=texnansx --feature=kern --feature=liga --feature=lnum --map-file=NexusProSans.map NexusSansPro-Bold.otf 
otftotfm --no-updmap --vendor=Fontshop --name=NexusProSans-Bold-Italic --verbose --encoding=texnansx --feature=kern --feature=liga --feature=lnum --map-file=NexusProSans.map NexusSansPro-BoldItalic.otf 
otftotfm --no-updmap --vendor=Fontshop --name=NexusProSans-Bold-SmallCaps --verbose --encoding=texnansx --feature=kern --feature=liga --feature=lnum --feature=smcp --map-file=NexusProSans.map NexusSansPro-Bold.otf 
otftotfm --no-updmap --vendor=Fontshop --name=NexusProSans-Bold-Slanted --slant=.167 --verbose --encoding=texnansx --feature=kern --feature=liga --feature=lnum --map-file=NexusProSans.map NexusSansPro-Bold.otf 


# Install fonts for the Texlive distribution (ubuntu) into a local texmf tree.
# '~/texmf' is the standard path for a local tree (ubuntu).

# Move generated fonts
mkdir -p ~/texmf/fonts/enc/dvips/Fontshop/
mv *.enc ~/texmf/fonts/enc/dvips/Fontshop/

mkdir -p ~/texmf/fonts/map/
mv *.map ~/texmf/fonts/map/

mkdir -p ~/texmf/fonts/tfm/Nexus/
mv *.tfm ~/texmf/fonts/tfm/Nexus/

mkdir -p ~/texmf/fonts/vf/Nexus/
mv *.vf ~/texmf/fonts/vf/Nexus/

mkdir -p ~/texmf/fonts/type1/Nexus/
mv *.pfb ~/texmf/fonts/type1/Nexus/

mkdir -p ~/texmf/tex/latex/
cp -r Nexus ~/texmf/tex/latex/
# Update the LaTeX filedatabase

texhash ~/texmf/

# Enable font maps and update the font map database

#updmap --enable Map=NexusProSans.map
#updmap --enable Map=NexusProSerif.map

updmap
