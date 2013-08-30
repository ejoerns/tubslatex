#! /bin/sh
#
# tubslatex installer script
#
# (c) 2013 by Enrico Jörns
#

# Halt on error
set -e

ECHO=/bin/echo

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
    $ECHO "$2" | fold -w80 -s >&3 || true
  fi
  $ECHO "$2" | fold -w80 -s >> $logfile || true
}

check_os() {
  OS_NAME=""
  case "$(uname)" in
    "Darwin")
      OS_NAME="Darwin"
      log_d "OS found: Darwin"
      ;;
    "Linux")
      OS_NAME="Linux"
      log_d "OS found: Linux"
      ;;
    *)
      log_d "OS unknown: $(uname)"
  esac
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


check_texlive() {
  # check for kpsewhich
  status=0
  command -v kpsewhich >/dev/null 2>&1 || status=1
  if [ $status = 0 ]; then
    log_d "kpsewhich found"
    return 0
  fi
  
  log_e "Program 'kpsewhich' not found."
  log_e "Be sure to use texlive or mactex!"
  exit 1
}

#--- checks if sudo is available
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

#--- shows short usage page
print_usage() {
  $ECHO "tubslatex Installer"
  $ECHO ""
  $ECHO "Syntax: sh install.sh [option] <path/to/tubslatex.tds.zip>"
  $ECHO ""
  $ECHO "where <path/to/tubslatex.tds.zip> can be both"
  $ECHO "a local and a remote file (http(s)/ftp)"
  $ECHO ""
  $ECHO "OPTIONS:"
  $ECHO "    -h    Show this help page"
  $ECHO "    -d    Show Debug output"
}

#--- Processes command line arguments
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
}

#--- Downloads $zipurl to $unzipdir
download_tds_zip() {
  check_downloader
  $ECHO -n "Downloading zipped tds file..."
  if $download_cmd $zipurl > $unzipdir/texlive_tubs.zip 2>>$logfile; then
    $ECHO "done."
  else
    $ECHO "failed."
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
        $ECHO "Installed in TEXMFLOCAL"
      ;;
      $(kpsewhich --var-value TEXMFHOME || "null")*)
        $ECHO "Installed in TEXMFHOME"
      ;;
      $(kpsewhich --var-value TEXMFDIST || "null")*)
        $ECHO "Installed in TEXMFDIST"
      ;;
      $(kpsewhich --var-value TEXMFMAIN || "null")*)
        $ECHO "Installed in TEXMFMAIN"
      ;;
      *)
      $ECHO "Installed in $($ECHO $tubsartcl | sed 's/tubsartcl.cls//g' || true)"
      ;;
    esac
    read -p "Do yout want to overwrite it? (y/n)" yesno
    case $yesno in
      y|Y)
        ;;
      *)
        $ECHO "Nothing will be done."
        exit 1
        ;;
    esac
  fi;
}

#-------------------------------------------------------------------------------

# generate temporary logfile
logfile=$(mktemp /tmp/texlive-tubs.log.XXXXXXXX)
chmod 777 $logfile

# Process user arguments
process_arguments $@

check_os
check_texlive
check_sudo

if [ -z $zipurl ]; then
  log_i "No explicit tubslatex archive given"
  read -p "Do you want to install the latest stable release automatically? (y/n)" yesno
  case $yesno in
    y|Y)
      zipurl=http://enricojoerns.de/tubslatex/tubslatex_latest_stable.tds.zip
      ;;
    *)
      $ECHO "Nothing will be done."
      $ECHO "Use -h option for usage information"
      exit 1
      ;;
  esac
fi

check_previous_tubslatex

# create tmpdir
unzipdir=$(mktemp -d /tmp/texlive-tubs.XXXXXXXX)
log_d "unzipdir dir is $unzipdir"

# download
if [ ! -f $zipurl ]; then
  log_d "File $zipurl not found local, trying to download"
  download_tds_zip
else
  log_d "File $zipurl found local"
  cp $zipurl $unzipdir/texlive_tubs.zip || log_e "Copying zip failed"
fi

# extract
$ECHO -n "Extracting..."
if unzip -o $unzipdir/texlive_tubs.zip -d $unzipdir >> $logfile 2>&1; then
	$ECHO "done."
else
	$ECHO "failed."
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
if [ "$OS_NAME" = "Linux" ]; then
status=0
command -v apt-get >/dev/null 2>&1 || status=1
if [ $status = 0 ]; then
  $ECHO "apt-get was found on your system."
  read -p "Do you want to install required dependencies now? [y/n]" yesno
  case $yesno in
    y|Y)
      $ECHO -n "Running apt-get. This may take some time..."
      if $rootrun apt-get -y install texlive-base texlive-latex-extra \
          texlive-fonts-extra latex-beamer texlive-fonts-recommended \
          texlive-lang-german texlive-extra-utils cm-super | tee $logfile; then
        $ECHO "done."
      else
        $ECHO "failed."
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

$ECHO -n "Copying files to TEXMFLOCAL..."
if $rootrun cp -r $unzipdir/doc $unzipdir/fonts $unzipdir/tex $texmfdir/.; then
  $ECHO "done."
  rm -rf $unzipdir || true
else
  $ECHO "failed."
  rm -rf $unzipdir || true
  exit 1
fi

$ECHO -n "Running mktexlsr..."
if $rootrun mktexlsr >> $logfile 2>&1; then
  $ECHO "done."
else 
  $ECHO "failed. Output has been stored in"
  $ECHO "$logfile"
  $ECHO "Please include this file if you report a bug."
	error_occured=1
fi

$ECHO -n "Checking fontmap..."
if pdftexmap=`kpsewhich pdftex.map` >> $logfile 2>&1; then
  $ECHO "done."
  $ECHO "Found map file: $pdftexmap" >> $logfile
else
  $ECHO "failed. Output has been stored in"
  $ECHO "$logfile"
  $ECHO "Please include this file if you report a bug."
  exit 1
  error_occured=1
fi
    
if [ -z `$ECHO $pdftexmap | grep /var/lib` ]; then
  $ECHO ""
  $ECHO "Warning: You seem to use a local font map\n  ($pdftexmap)."
  $ECHO "Only global font maps are supported in this installation"
  read -p "Do you want to delete local font map? [y/n]" yesno
  case $yesno in
    y|Y)
      $ECHO -n "Deleting $pdftexmap..."
      $rootrun rm -f $pdftexmap
      $ECHO "done."
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
      
# Check if getnonfreefonts is available
status=0
command -v getnonfreefonts >/dev/null 2>&1 || status=1
if [ $status = 0 ]; then
  log_d "getnonfreefonts found"
else
  $ECHO ""
  $ECHO "'getnonfreefonts' was not found on your system."
  $ECHO "Do you want automatically download and install it? [y/n]"
  read yesno
  if [ $yesno = "y" ]; then
    $ECHO -n "Downloading and installing getnonfreefonts..."
    if wget -P /tmp http://tug.org/fonts/getnonfreefonts/install-getnonfreefonts >> $logfile 2>&1; then
      $rootrun texlua /tmp/install-getnonfreefonts >> $logfile 2>&1
      rm -f /tmp/install-getnonfreefonts
    $ECHO "done."
    else
      $ECHO "failed. Output has been stored in"
      $ECHO "$logfile"
      $ECHO "Please include this file if you report a bug."
      $ECHO "-- You may need to install Arial later manually --"
    fi
  else
    $ECHO "Warning: Arial will not be installed!"
    $ECHO "-- You may need to install Arial later manually --"
  fi
fi

$ECHO -n "Running getnonfreefonts to install arial-urw..."
if $rootrun getnonfreefonts --sys --verbose arial-urw >> $logfile 2>&1; then
  $ECHO "done."
else
  $ECHO "failed. Output has been stored in"
  $ECHO "$logfile"
  $ECHO "Please include this file if you report a bug."
  $ECHO "-- You may need to install Arial later manually --"
  error_occured=1
fi

# Check for already available Mapfiles
# (Some updmap versions fail trying to enable an active map)
npsans=`updmap-sys --listmaps 2>&1 | grep NexusProSans | grep -v ! | grep -v disabled || true`
npserif=`updmap-sys --listmaps 2>&1 | grep NexusProSerif | grep -v ! | grep -v disabled || true`

# Enable Nexus maps
if [ -z "$npsans" ]; then
  $ECHO -n "Adding map file for NexusProSans..."
  if $rootrun updmap-sys --nomkmap --nohash --enable Map=NexusProSans.map >> $logfile 2>&1; then
    $ECHO "done."
  else
    $ECHO "failed.\n Output has been stored in"
    $ECHO "$logfile"
    $ECHO "Please include this file if you report a bug."
  fi
else
  $ECHO "NexusProSans already enabled, skipping."
fi
if [ -z "$npserif" ]; then
  $ECHO -n "Adding map file for NexusProSerif..."
  if $rootrun updmap-sys --nomkmap --nohash --enable Map=NexusProSerif.map >> $logfile 2>&1; then
    $ECHO "done."
  else
    $ECHO "failed.\n Output has been stored in"
    $ECHO "$logfile"
    $ECHO "Please include this file if you report a bug."
  fi
else
  $ECHO "NexusProSerif already enabled, skipping."
fi

# Run updmap to update font db
$ECHO -n "Running updmap-sys..."
if $rootrun updmap-sys >> $logfile 2>&1; then
  $ECHO "done."
else
  $ECHO "failed. Output has been stored in"
  $ECHO "$logfile"
  $ECHO "Please include this file if you report a bug."
  error_occured=1
fi

if [ error_occured = 1 ]; then
  log_w "An error occured during installation."
  $ECHO "See log $logfile for further information"
else
  $ECHO "---"
  $ECHO "tubslatex was installed successfully"
  log_d "Output has been stored in $logfile"
fi;


exit 0
