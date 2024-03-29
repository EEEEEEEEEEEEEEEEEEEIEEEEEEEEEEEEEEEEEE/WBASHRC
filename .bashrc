#!/etc/skel/.bashrc
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

# General settings
# ----------------
USERNAME=""
PASSWORD=""

# Portage (make.conf)
# ---------------------------------------------------------
# Stuff for make.conf are set here instead of in conf file
# ---------------------------------------------------------
export NUMCPUS=$(nproc)
export NUMCPUSPLUSONE=$(( NUMCPUS + 1 ))
export MAKEOPTS="-j${NUMCPUSPLUSONE} -l${NUMCPUS}"
export EMERGE_DEFAULT_OPTS="--jobs=${NUMCPUSPLUSONE} --load-average=${NUMCPUS}"

# Locales
export LANG=en_SE.UTF-8
export LC_PAPER="en_SE.UTF-8"
export LC_ADDRESS="en_SE.UTF-8"
export LC_TELEPHONE="en_SE.UTF-8"
export LC_MEASUREMENT="en_SE.UTF-8"
export LC_IDENTIFICATION="en_SE.UTF-8"

# Misc stuff for portage
# ----------------------
# Upgrade Entire System
alias upgrade="emerge -avuDN --with-bdeps y --keep-going world"

# Our bash prompt
# -----------------------------------
# We want it as simple as possible
# and not any l33t h4cking shit stuff
# this is gentoo default but different(magenta) colour
# -----------------------------------
if [[ $EUID -eq "root" ]]; then
  export PS1="\[\033]0;\u@\h:\w\007\]\[\033[01;31m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] "
else
  export PS1="\[\033]0;\u@\h:\w\007\]\[\033[01;35m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] "
fi

# Text Editor
# ----------------------
# If we copy and pasting
# from some site that
# using anything else
# then vim, we want vim
# ----------------------
alias pico="vim"
alias nano="vim"
alias vi="vim"
alias emacs="vim"
alias sublime-text="vim"

# Password Generator
# ----------------------
# Takes 0.01 Seconds ;p
# ----------------------
pwgen() { cat /dev/urandom|tr -dc 'a-zA-Z0-9-_!@#$%^&*()_+{}|:<>?='|fold -w 36| head -n 4|xargs|sed 's/ //g';}

# Kernel Theme
#---------------------------------
# Get a black background instead of 
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

# Find all extensions in recursive from current folder, they will be sorted like jpg, pl, sh
alias extensions="find . -type f | perl -ne 'print $1 if m/\.([^.\/]+)$/' | sort -u"

# List all ip-addresses you are connected with right now
alias connected="netstat -lantp | grep ESTABLISHED |awk '{print $5}' | awk -F: '{print $1}' | sort -u"

# Sort all folders by alphabet
alias sortalpha="
for i in *; do I=`echo $i|cut -c 1|tr a-z A-Z`; if [ ! -d "$I" ]; then mkdir "$I"; fi; mv "$i" "$I"/"$i"; done"

# Qemu Virtual Boxes
win10() {
         cd ~/qemu/windows10
         qemu-system-x86_64 \
         -enable-kvm \
         -cpu host \
         -smp 8 \
         -device usb-ehci,id=ehci \
         -net nic -net user \
         -hda win10.img 
     }

# Mount Thinclient to /mnt/thinclient
alias mountthinclient="sudo mount -t cifs -o username=$USERNAME,password=$PASSWORD //192.168.1.106/localdisk /mnt/thinclient/"

# Rdeskop
alias thinclient="rdesktop -u $USERNAME -p $PASSWORD -g 1024x768 -c /tmp/ -n thinclient -k sv -C -T thinclient -N -a 24 -r clipboard:CLIPBOARD -r sound:local 192.168.1.106"

# SSH
alias h="ssh $USERNAME@wuseman.se"
alias n="ssh $USERNAMEA@nr1.nu"
alias t="ssh $USERNAME@thinclient"

# Weechat
alias weechat="ssh -t $USERNAME@wuseman.se screen -rd weechat"
