# Author: wuseman <wuseman@nr1.nu>
# --------------------------------------------
# Just my simple bashrc, I am so tired
# to re-write this shit so i decided
# to create a repo for this so I have a backup
# since I lost my old one, AGAIN!  ;(
# --------------------------------------------

# Portage
# -------
export NUMCPUS=$(nproc)
export NUMCPUSPLUSONE=$(( NUMCPUS + 1 ))
export MAKEOPTS="-j${NUMCPUSPLUSONE} -l${NUMCPUS}"
export EMERGE_DEFAULT_OPTS="--jobs=${NUMCPUSPLUSONE} --load-average=${NUMCPUS}"

# Password Generator
# Takes 0.01 Seconds ;p
# ----------------------
pwgen() { cat /dev/urandom|tr -dc 'a-zA-Z0-9-_!@#$%^&*()_+{}|:<>?='|fold -w 36| head -n 4|xargs|sed 's/ //g';}

# Kernel
#---------------------------------
# Get a black backgruond instead of 
# the default gray/blue setup
# - Use mono if you want black/white
#---------------------------------
export MENUCONFIG_COLOR="blackbg"

# Aliases
# Just some aliases to make my life easier
# ----------------------------------------
alias make="make -j8 -l9"
alias myip="curl -s https://nr1.nu/i/"

