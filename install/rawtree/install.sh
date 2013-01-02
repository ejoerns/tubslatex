#! /bin/sh
# postinst script for latex-beamer
#
# see: dh_installdeb(1)

set -e

error_occured=0

exec 3>&2 # logging stream (file descriptor 3) defaults to STDERR
verbosity=2 # default to show warnings
silent_lvl=0
err_lvl=1
wrn_lvl=2
inf_lvl=3
dbg_lvl=4

# log functions
log_n() { log $silent_lvl "NOTE: $1"; } # Always prints
log_e() { log $err_lvl "ERROR: $1"; }
log_w() { log $wrn_lvl "WARNING: $1"; }
log_i() { log $inf_lvl "INFO: $1"; } # "info" is already a command
log_d() { log $dbg_lvl "DEBUG: $1"; }
log() {
  if [ $verbosity -ge $1 ]; then
    # Expand escaped characters, wrap at 70 chars, indent wrapped lines
    echo "$2" | fold -w70 -s | sed '2~1s/^/  /' >&3 || true
  fi
}

# generate temporary logfile
logfile=$(mktemp -p /tmp texlive-tubs.XXXXXXXX)
chmod 777 $logfile

# Handle verbosity option
if [ ! -z $1 ]; then
  if [ "$1" = "-v" ]; then
    verbosity=4
    log_d "verbosity on"
  else
    log_w "Unknown parameter: $1"
  fi
fi

# Make sure only root can run our script
if ! [ $(id -u) = 0 ]; then
  log_e "This script must be run as root" 1>&2
  exit 1
fi

# Check if tlmgr is available
status=0
command -v tlmgr >/dev/null 2>&1 || status=1
if [ $status = 0 ]; then
  echo "tlmgr installed, but not yet supported"
else
  log_d "tlmgr not installed"
fi


# Check if apt-get is available and allow automatic package installation
status=0
command -v apt-get >/dev/null 2>&1 || status=1
if [ $status = 0 ]; then
	echo "apt-get was found on your system."
	read -p "Do you want to automatically install dependencies? [y/n]" yesno
  case $yesno in
    y|Y)
      echo -n "Running apt-get. This may take some time..."
      if apt-get -y install texlive-base texlive-latex-extra \
          texlive-fonts-extra latex-beamer texlive-fonts-recommended \
          texlive-lang-german texlive-extra-utils cm-super | tee $logfile; then
        echo "done."
      else
        echo "failed."
        error_occured=1
      fi
      ;;
    *)
      log_w "You may need to install tex packages manually after install!"
      ;;
  esac
else
	log_d "apt-get not found"
fi


# get TEXMFLOCAL path
texmfdir=$(kpsewhich --var-value TEXMFLOCAL || echo "TEXMFLOCAL not found")

if [ ! -d doc ] || [ ! -d fonts ] || [ ! -d tex ]; then
	log_e "Did not find all required directories"
	exit 1
else
	log_d "directories ok"
fi

echo -n "Copying files "
cp -r doc fonts tex $texmfdir/.
echo "[DONE]"

# exit 0

echo -n "Running mktexlsr..."
if mktexlsr >> $logfile 2>&1; then
  echo "done."
else 
  echo "failed. Output has been stored in"
  echo "$logfile"
  echo "Please include this file if you report a bug."
	error_occured=1
fi

echo -n "Checking fontmap..."
if pdftexmap=`kpsewhich pdftex.map` >> $logfile 2>&1; then
  echo "done."
  echo "Found map file: $pdftexmap" >> $logfile
else
  echo "failed. Output has been stored in"
  echo "$logfile"
  echo "Please include this file if you report a bug."
  exit 1
  error_occured=1
fi
    
#    varlibmap=``
#    echo "varlibmap: $varlibmap"
if [ -z `echo $pdftexmap | grep /var/lib` ]; then
  echo ""
  echo "Warning: You seem to use a local font map\n  ($pdftexmap)."
  echo "Only global font maps are supported in this installation"
  read -p "Do you want to delete local font map? [y/n]" yesno
  case $yesno in
    y|Y)
      echo -n "Deleting $pdftexmap..."
      rm -f $pdftexmap
      echo "done."
      ;;
    *)
      log_w "You may need to run updmap manually after install!"
      error_occured=0
      ;;
  esac
fi

# Touch 10local.cfg to prevent errors of buggy updmap
# TODO: This step might be skipped in texlive 201x
mkdir -p /etc/texmf/updmap.d || true
touch /etc/texmf/updmap.d/10local.cfg || true
      
# Check for getnonfreefonts and install if needed
# Is either located at /usr/bin/getnonfreefonts (as symlink)
# or at /usr/local/bin/getnonfreefonts
if ([ ! -x /usr/bin/getnonfreefonts ] && [ ! -x /usr/local/bin/getnonfreefonts ]); then
  echo ""
  echo "'getnonfreefonts' was not found on your system."
  echo "Do you want automatically download and install it? [y/n]"
  read yesno
  if [ $yesno = "y" ]; then
    echo -n "Downloading and installing getnonfreefonts..."
    if wget -P /tmp http://tug.org/fonts/getnonfreefonts/install-getnonfreefonts >> $logfile 2>&1; then
      texlua /tmp/install-getnonfreefonts >> $logfile 2>&1
      rm -f /tmp/install-getnonfreefonts
    echo "done."
    else
      echo "failed. Output has been stored in"
      echo "$logfile"
      echo "Please include this file if you report a bug."
      echo "-- You may need to install Arial later manually --"
    fi
  else
    echo "Warning: Arial will not be installed!"
    echo "-- You may need to install Arial later manually --"
  fi
fi

echo -n "Running getnonfreefonts to install arial-urw..."
if getnonfreefonts --sys --verbose arial-urw >> $logfile 2>&1; then
  echo "done."
else
  echo "failed. Output has been stored in"
  echo "$logfile"
  echo "Please include this file if you report a bug."
  echo "-- You may need to install Arial later manually --"
  error_occured=1
fi

# Check for already available Mapfiles
# (Some updmap versions fail trying to enable an active map)
npsans=`updmap-sys --listmaps 2>&1 | grep NexusProSerif | grep -v ! | grep -v disabled || true`
npserif=`updmap-sys --listmaps 2>&1 | grep NexusProSerif | grep -v ! | grep -v disabled || true`

# Enable Nexus maps
if [ -z "$npsans" ]; then
  echo -n "Adding map file for NexusProSans..."
  if updmap-sys --nomkmap --nohash --enable Map=NexusProSans.map >> $logfile 2>&1; then
    echo "done."
  else
    echo "failed.\n Output has been stored in"
    echo "$logfile"
    echo "Please include this file if you report a bug."
  fi
else
  echo "NexusProSans already enabled, skipping."
fi
if [ -z "$npserif" ]; then
  echo -n "Adding map file for NexusProSerif..."
  if updmap-sys --nomkmap --nohash --enable Map=NexusProSerif.map >> $logfile 2>&1; then
    echo "done."
  else
    echo "failed.\n Output has been stored in"
    echo "$logfile"
    echo "Please include this file if you report a bug."
  fi
else
  echo "NexusProSerif already enabled, skipping."
fi

# Run updmap to update font db
echo -n "Running updmap-sys..."
if updmap-sys >> $logfile 2>&1; then
  echo "done."
else
  echo "failed. Output has been stored in"
  echo "$logfile"
  echo "Please include this file if you report a bug."
  error_occured=1
fi


# delete temp file if empty
# if [ -s $FILE ]; then
#   log_d "$logfile has data."
# else
#   log_d "$logfile is empty. Will be deleted"
#   rm -f $logfile
# fi

if [ error_occured = 1 ]; then
  log_w "An error occured during installation."
  echo "See log $logfile for further information"
else
  log_d "Output has been stored in $logfile"
fi;


exit 0
