#!/bin/bash

###
## Install utils as root:
##   apt install sane
##   apt install sane-utils
##
## Get appropriate libraries and copy to /usr/local/sane/epjitsu
##   https://www.josharcher.uk/code/install-scansnap-s1300-drivers-linux/
##   Follow directions there and confirm that /etc/sane.d/epjitsu.conf is set correctly
##
## Install scanbd
##   apt install scanbd
##   edit /etc/sane.d/dll.conf and REMOVE everything except -net- line
##   edit /etc/scanbd/dll.conf and ensure all lines except --net-- line
##   copy this script where you want it &&
##    update all references for test.script in /etc/scanbd/scanbd.conf
##
## Using scanimage -
##   Confirm you can see the scanner - use line in the below
##
###

SCANNER='net:localhost:epjitsu:libusb:001:003'

# look in scanbd.conf for environment variables
logger -t "scanbd: $0" "Begin of $SCANBD_ACTION for device $SCANBD_DEVICE"

# printout all env-variables

# cd to tmp dir and do the scan
OUTDIR=/tmp/scanbd.out.`date +%Y%m%d-%H%M%S`
mkdir -p $OUTDIR
cd $OUTDIR
/usr/bin/printenv > $OUTDIR/scanbd.script.env

# Actually do the scan
#  change Gray -> Color for color
#  change "ADF Duplex" -> 'ADF Front' for Single Sided
/usr/bin/scanimage -b --format png -d ${SCANNER} --resolution 200  --source 'ADF Duplex' --mode Gray

# fix files names cause otherwise convert uses wrong order if > 9 pages
if [ -f out1.png ] ; then mv out1.png out01.png ; fi
if [ -f out2.png ] ; then mv out2.png out02.png ; fi
if [ -f out3.png ] ; then mv out3.png out03.png ; fi
if [ -f out4.png ] ; then mv out4.png out04.png ; fi
if [ -f out5.png ] ; then mv out5.png out05.png ; fi
if [ -f out6.png ] ; then mv out6.png out06.png ; fi
if [ -f out7.png ] ; then mv out7.png out07.png ; fi
if [ -f out8.png ] ; then mv out8.png out08.png ; fi
if [ -f out9.png ] ; then mv out9.png out09.png ; fi

# now convert to PDF
OUTFILE=`date +%Y_%m_%d-%H%M%S`.pdf
convert *png $OUTFILE

logger -t "scanbd: $0" "End   of $SCANBD_ACTION for device $SCANBD_DEVICE"A
