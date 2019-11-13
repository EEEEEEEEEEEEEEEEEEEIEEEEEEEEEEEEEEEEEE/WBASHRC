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
# ----------------------
# Takes 0.01 Seconds ;p
# ----------------------
pwgen() { cat /dev/urandom|tr -dc 'a-zA-Z0-9-_!@#$%^&*()_+{}|:<>?='|fold -w 36| head -n 4|xargs|sed 's/ //g';}

# Kernel Theme
#---------------------------------
# Get a black backgruond instead of 
# the default gray/blue setup
# - Use mono if you want black/white
#---------------------------------
export MENUCONFIG_COLOR="blackbg"


# Kernel stuff
#---------------------------------
# Update/Upgrade kernel easy as
# peasy and also upgrade grub
# with our new kernel image.
#---------------------------------
kernel() {
cat /proc/mounts |grep -wioq boot
if [[ "$?" -eq "0" ]]; then 
	cd /usr/src/linux
	make menuconfig
	make
	make modules_install
	make install
	grub-mkconfig -o /boot/grub/grub.cfg
	 read -p "Reboot (Y/n): " rebootkernel
	 	 case ${rebootkernel} in
	    		 "Y|Yes|YES") reboot ;;
	   		  "*") echo "All Done .." ;;
                 esac
else
       echo "Duh, mount boot partition before you moving further ..."
fi
}

# Aliases
# ----------------------------------------
# Just some aliases to make my life easier
# ----------------------------------------
alias make="make -j8 -l9"
alias myip="curl -s https://nr1.nu/i/"

