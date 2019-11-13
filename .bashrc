# Portage
export NUMCPUS=$(nproc)
export NUMCPUSPLUSONE=$(( NUMCPUS + 1 ))
export MAKEOPTS="-j${NUMCPUSPLUSONE} -l${NUMCPUS}"
export EMERGE_DEFAULT_OPTS="--jobs=${NUMCPUSPLUSONE} --load-average=${NUMCPUS}"

# Create a good password
pwgen() { cat /dev/urandom|tr -dc 'a-zA-Z0-9-_!@#$%^&*()_+{}|:<>?='|fold -w 36| head -n 4|xargs|sed 's/ //g';}

# Kernel
#---------------------------------
# Get a black backgrund instead of 
# the default gray/blue setup
# - Use mono if you want black/white
#---------------------------------
export MENUCONFIG_COLOR="blackbg"

# Aliases
alias make="make -j8 -l9"
