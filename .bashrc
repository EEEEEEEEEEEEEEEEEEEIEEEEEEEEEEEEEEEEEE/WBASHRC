# Author: wuseman <wuseman@nr1.nu>
# --------------------------------------------
# Just my simple bashrc, I am so tired
# to re-write this shit so i decided
# to create a repo for this so I have a backup
# since I lost my old one, AGAIN!  ;(
# --------------------------------------------
# If you love one-liners, then you can find 
# my personal and unique oneliners at: 
# https://www.commandlinefu.com/commands/by/wuziduzi
# for more cool one liners I have shared
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
cat /proc/mounts|grep -wioq boot
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

# Disk Space
# -----------------------------------
# Print how much usage you have
# used of your current root partition
# in GB; example: 
# Currently used 16GB of 430GB
# -----------------------------------
dff() {
USED=$(df -klP -t xfs -t ext2 -t ext3 -t ext4 -t reiserfs|grep -oE ' [0-9]{1,}( +[0-9]{1,})+' |awk '{sum_used += $2} END {printf "%.0fGB\n", sum_used/1024/1024}')
TOTAL="$(df -h|grep -w /|awk '{print $4}'|sed 's/$/B/g')"
echo "Currently used $USED of $TOTAL"
}

# Aliases
# ----------------------------------------
# Just some aliases to make my life easier
# ----------------------------------------

# We want to use all cores by default
alias make="make -j8 -l9"

# Check WAN IP
alias myip="curl -s https://nr1.nu/i/"

# Real time acitivity manager, showing top 10 most hardware used tools
alias activity="watch -n 1 'ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head'"

# List files that was created today only
alias lstoday="ls -al --time-style=+%D| grep `date +%D`"

# List wich ports you got open (good for know wich port to use when create iptables)
alias openports="lsof -i -nlP|awk '{print $9, $8, $1}'|sed 's/.*://'|sort -u"

# Show current network interface in use
alias interface="route | grep -m1 ^default | awk '{print $NF}'"

# Show all devices on your network sorted in a nice column output
alias netdiscover="nmap -sn 192.168.1.0/24 -oG - | awk '$4=="Status:" && $5=="Up" {print $0}'|column -t"
