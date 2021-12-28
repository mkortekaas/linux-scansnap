#!/bin/bash

###
##
## Using scanimage -
##   If running this manually you will need the SCANDB_DEVICE ENV set
##     See scanimage -L 
##
###

## Scanner should come in as SCANBD_DEVICE
#SCANBD_DEVICE='net:localhost:epjitsu:libusb:001:003'
#SCANBD_DEVICE='epjitsu:libusb:001:005'
SRCDIR=/home/markk/github/linux-scansnap
HOMEDIR=/home/markk/scanbd
GDRIVE=/root/go/bin/gdrive

# obtain $GPARENT variable (key not for github)
# Set this ENV to be the directory ID you want from 'gdrive list'
source $SRCDIR/gdrive.env

# look in scanbd.conf for environment variables
logger -t "scanbd: $0" "Begin of $SCANBD_ACTION for device $SCANBD_DEVICE"


# Where do you want files stored?
# cd to tmp dir and do the scan
OUTDIR=${HOMEDIR}/scanbd.`date +%Y%m%d-%H%M%S`
mkdir -p $OUTDIR
cd $OUTDIR

# printout all env-variables for debugging
/usr/bin/printenv > $OUTDIR/scanbd.script.env

# Actually do the scan
#  change Gray -> Color for color
#  change "ADF Duplex" -> 'ADF Front' for Single Sided
/usr/bin/scanimage -b --format png -d ${SCANBD_DEVICE} --resolution 200  --source 'ADF Duplex' --mode Gray

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

# copy this file where you want it - usually a cloud location
# Setup this separately
${GDRIVE} upload -p ${GPARENT} $OUTFILE

# Cleanup the files we've used / OPTIONAL 
#if [ -f ${FINALDEST}/${OUTFILE} ] ; then
#    cd /tmp
#    echo "Deleting tmp location ..."
#    rm -rf OUTDIR
#fi

# finish the logging
logger -t "scanbd: $0" "End   of $SCANBD_ACTION for device $SCANBD_DEVICE"
