#! /bin/sh
#
# tubslatex installer script
#
# (c) 2013 by Enrico Jörns
#

# Halt on error
set -e

error_occured=0

exec 3>&2 # logging stream (file descriptor 3) defaults to STDERR
verbosity=2 # default to show warnings
silent_lvl=0
err_lvl=1
wrn_lvl=2
inf_lvl=3
dbg_lvl=4

#--- log functions
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
  echo "$2" | fold -w70 -s | sed '2~1s/^/  /' >> $logfile || true
}

#--- Checks for either wget or curl and stores result in 'download_cmd'
check_downloader() {

  download_cmd=""
  # check for wget
  status=0
  command -v wget >/dev/null 2>&1 || status=1
  if [ $status = 0 ]; then
    log_d "wget found"
    download_cmd="wget -q -O 	-"
    return 0
  else
    log_d "wget not found"
  fi

  # check for curl
  status=0
  command -v curl >/dev/null 2>&1 || status=1
  if [ $status = 0 ]; then
    log_d "curl found"
    download_cmd="curl -sS"
    return 0
  else
    log_d "curl not found"
  fi
  
  log_e "Download failed. Neither 'curl' nor 'wget' was found on your system."
  exit 1
}

# check if sudo is available
check_sudo() {
  rootrun=""
  if sudo -v >/dev/null 2>&1; then
    log_d "sudo ok"
    rootrun="sudo"
  else
    log_d "sudo failed"
    # Check if user is root (might be unnecessary)
    if ! [ $(id -u) = 0 ]; then
      log_e "This script must be run as root" 1>&2
      exit 1
    fi
  fi
}

print_usage() {
  echo "tubslatex Installer"
  echo ""
  echo "Syntax: sh install.sh [option] <path/to/tubslatex.tds.zip>"
  echo ""
  echo "where <path/to/tubslatex.tds.zip> can be both"
  echo "a local and a remote file (http(s)/ftp)"
  echo ""
  echo "OPTIONS:"
  echo "    -h    Show this help page"
  echo "    -d    Show Debug output"
}

process_arguments() {
  zipurl=""

  for var in "$@"
  do
    case "$var" in
    "-d")
      verbosity=4
      log_d "verbosity on"
      ;;
    "-h")
      print_usage
      exit 0
      ;;
    *)
      zipurl=$var
      ;;
    esac
  done
  
  if [ -z $zipurl ]; then
    log_e "No filename given"
    echo ""
    print_usage
    exit 1;
  fi
}

#--- Downloads $zipurl to $unzipdir
download_tds_zip() {
  check_downloader
  echo -n "Downloading zipped tds file..."
  if $download_cmd $zipurl > $unzipdir/texlive_tubs.zip 2>>$logfile; then
    echo "done."
  else
    echo "failed."
    log_e "Unable to download $zipurl."
    exit 1
  fi
}

#--- Checks for previous tubslatex installations
check_previous_tubslatex() {
  tubsartcl=$(kpsewhich tubsartcl.cls) || true
  if [ ! -z $tubsartcl ]; then
    log_w "Previous installation of tubslatex was found!"
    # Checks for installation directory
    case $tubsartcl in
      $(kpsewhich --var-value TEXMFLOCAL || "null")*)
        echo "Installed in TEXMFLOCAL"
      ;;
      $(kpsewhich --var-value TEXMFHOME || "null")*)
        echo "Installed in TEXMFHOME"
      ;;
      $(kpsewhich --var-value TEXMFDIST || "null")*)
        echo "Installed in TEXMFDIST"
      ;;
      $(kpsewhich --var-value TEXMFMAIN || "null")*)
        echo "Installed in TEXMFMAIN"
      ;;
      *)
      echo "Installed in $(echo $tubsartcl | sed 's/tubsartcl.cls//g' || true)"
      ;;
    esac
    read -p "Do yout want to overwrite it? (y/n)" yesno
    case $yesno in
      y|Y)
        ;;
      *)
        echo "Nothing will be done."
        exit 1
        ;;
    esac
  fi;
}

#-------------------------------------------------------------------------------

# generate temporary logfile
logfile=$(mktemp -p /tmp texlive-tubs.log.XXXXXXXX)
chmod 777 $logfile

# Process user arguments
process_arguments $@

check_sudo
check_previous_tubslatex

# create tmpdir
unzipdir=$(mktemp -d /tmp/texlive-tubs.XXXXXXXX)

# download
if [ ! -f $zipurl ]; then
  log_d "File $zipurl not found local, trying to download"
  download_tds_zip
else
  log_d "File $zipurl found local"
  cp $zipurl $unzipdir/texlive_tubs.zip || log_e "Copying zip failed"
fi

# extract
echo -n "Extracting..."
if unzip $unzipdir/texlive_tubs.zip -d $unzipdir >> $logfile 2>&1; then
	echo "done."
else
	echo "failed."
	log_e "Unable to extract zip archive $unzipdir/texlive_tubs.zip"
	rm -rf $unzipdir || true
	exit 1
fi
rm -f $unzipdir/texlive_tubs.zip


# Check if tlmgr is available
status=0
command -v tlmgr >/dev/null 2>&1 || status=1
if [ $status = 0 ]; then
  log_i "tlmgr installed, but not yet supported"
else
  log_d "tlmgr not installed"
fi


# Check if apt-get is available and allow automatic package installation
status=0
command -v apt-get >/dev/null 2>&1 || status=1
if [ $status = 0 ]; then
  echo "apt-get was found on your system."
  read -p "Do you want to install required dependencies now? [y/n]" yesno
  case $yesno in
    y|Y)
      echo -n "Running apt-get. This may take some time..."
      if $rootrun apt-get -y install texlive-base texlive-latex-extra \
          texlive-fonts-extra latex-beamer texlive-fonts-recommended \
          texlive-lang-german texlive-extra-utils cm-super | tee $logfile; then
        echo "done."
      else
        echo "failed."
        error_occured=1
      fi
      ;;
    *)
      log_w "You may need to install tex packages manually!"
      ;;
  esac
else
  log_d "apt-get not found"
fi


# get TEXMFLOCAL path
if texmfdir=$(kpsewhich --var-value TEXMFLOCAL); then
  log_d "TEXMFLOCAL found: $texmfdir"
else
  # TODO: handle?
  log_e "TEXMFLOCAL not found!"
  rm -rf $unzipdir || true
  exit 1
fi

if [ ! -d $unzipdir/doc ] || [ ! -d $unzipdir/fonts ] || [ ! -d $unzipdir/tex ]; then
  log_e "Did not find all required directories. Broken tds."
  rm -rf $unzipdir || true
  exit 1
else
  log_d "directories ok"
fi

echo -n "Copying files to TEXMFLOCAL..."
if cp -r $unzipdir/doc $unzipdir/fonts $unzipdir/tex $texmfdir/.; then
  echo "done."
  rm -rf $unzipdir || true
else
  echo "failed."
  rm -rf $unzipdir || true
  exit 1
fi

echo -n "Running mktexlsr..."
if $rootrun mktexlsr >> $logfile 2>&1; then
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
    
if [ -z `echo $pdftexmap | grep /var/lib` ]; then
  echo ""
  echo "Warning: You seem to use a local font map\n  ($pdftexmap)."
  echo "Only global font maps are supported in this installation"
  read -p "Do you want to delete local font map? [y/n]" yesno
  case $yesno in
    y|Y)
      echo -n "Deleting $pdftexmap..."
      $rootrun rm -f $pdftexmap
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
$rootrun mkdir -p /etc/texmf/updmap.d || true
$rootrun touch /etc/texmf/updmap.d/10local.cfg || true
      
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
      $rootrun texlua /tmp/install-getnonfreefonts >> $logfile 2>&1
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
if $rootrun getnonfreefonts --sys --verbose arial-urw >> $logfile 2>&1; then
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
  if $rootrun updmap-sys --nomkmap --nohash --enable Map=NexusProSans.map >> $logfile 2>&1; then
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
  if $rootrun updmap-sys --nomkmap --nohash --enable Map=NexusProSerif.map >> $logfile 2>&1; then
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
if $rootrun updmap-sys >> $logfile 2>&1; then
  echo "done."
else
  echo "failed. Output has been stored in"
  echo "$logfile"
  echo "Please include this file if you report a bug."
  error_occured=1
fi

if [ error_occured = 1 ]; then
  log_w "An error occured during installation."
  echo "See log $logfile for further information"
else
  echo "---"
  echo "tubslatex was installed successfully"
  log_d "Output has been stored in $logfile"
fi;


exit 0
