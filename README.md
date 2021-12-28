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
- [ ] copy this script where you want it && update all references for `test.script` in `/etc/scanbd/scanbd.conf`
- [ ] edit this script and set SRC/OUTput directories

## Using scanimage w/o button press
- If running this manually you will need the ${SCANDB_DEVICE} environment variable set && see `scanimage -L` output to confirm

## Mount your cloud service of choice (Google Drive from here down)
- Install go if not already installed (https://go.dev/doc/install) or `apt install gccgo-go`
- Install gdrive: https://github.com/prasmussen/gdrive `go install github.com/prasmussen/gdrive@latest`
- gdrive will now be in `/root/go/bin/gdrive`
- as root `/root/go/bin/gdrive about` -- follow that link to the account you want to use, accept and paste link back
- obtain the directory ID you want to store files as `gdrive list` - store this in gdrive.env:
```
export GPARENT=abcdef123
```

### other misc links that might help you
- https://virantha.com/2014/03/17/one-touch-scanning-with-fujitsu-scansnap-in-linux/
- https://jvns.ca/blog/2020/07/11/scanimage--scan-from-the-command-line/





