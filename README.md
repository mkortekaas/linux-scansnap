# linux-scansnap

This allows the S1300/S1300i to work on ubuntu with the button function

## This works on Ubuntu 20.4 LTS.
Install utils as root:
```
apt install sane
apt install sane-utils
```

## Get appropriate libraries and copy to /usr/local/sane/epjitsu
- [ ] See https://www.josharcher.uk/code/install-scansnap-s1300-drivers-linux/
- [ ] Follow directions there and confirm that `/etc/sane.d/epjitsu.conf` is set to the correct drivers
- [ ] `sane-find-scanner` will give a vendor/product ID that will match to a driver in that conf file
- [ ] You will need to `mkdir -p /usr/local/sane/epjisu` prior to the copy
- [ ] Ignore the step(s) to scan in the ubuntu interface(s), unless you want to manually scan

## Install scanbd
- [ ] `apt install scanbd`
- [ ] edit `/etc/sane.d/dll.conf` and REMOVE everything except -net- line
- [ ] edit `/etc/scanbd/dll.conf` and ensure all lines except -net- line
- [ ] copy this script where you want it && update all references for test.script in /etc/scanbd/scanbd.conf

## Using scanimage w/o button press
- If running this manually you will need the ${SCANDB_DEVICE} environment variable set && see `scanimage -L` output to confirm


