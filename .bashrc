# Portage
export NUMCPUS=$(nproc)
export NUMCPUSPLUSONE=$(( NUMCPUS + 1 ))
export MAKEOPTS="-j${NUMCPUSPLUSONE} -l${NUMCPUS}"
export EMERGE_DEFAULT_OPTS="--jobs=${NUMCPUSPLUSONE} --load-average=${NUMCPUS}"

# Kernel
#---------------------------------
# Get a black backgrund instead of 
# the default gray/blue setup
# - Use mono if you want black/white
#---------------------------------
export MENUCONFIG_COLOR="blackbg"

# Aliases
alias make="make -j8 -l9"
