#!/bin/bash
# 

cat << END >> /etc/profile

PS1='\h [\w] -\u- '
export TMOUT=1800
export LC_ALL=en_US.UTF-8

## Aliases
alias ..='cd ..'
alias ...='cd ../..'
alias Grep='grep'
alias SYNC='sync;sync;sync;sync;sync'
alias bye='sync;clear;exit'
alias cd..='cd ..'
alias cls='clear'
alias cpnull='cp /dev/null'
alias del='/bin/rm -i'
alias grep='egrep --color=auto'
alias egrep='egrep --color=auto'
alias lo='sync;clear;exit'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ls='ls --color=auto'
alias man='env LC_CTYPE=en_US.ISO8859-1 man'
alias md='mkdir'
alias mn='mesg n'
alias more='less'
alias mv='/bin/mv -i'
alias ncftp3='ncftp'
alias psl='psm'
alias psm='ps auxw|sort -k 1,2|more'
alias psmw='ps auxww|sort -k 1,2|more'
alias pss='ps auxw|sort -k 2|grep $USER'
alias psv='ps auxw|grep -v $USER|sort -k 2|more'
alias rd='rmdir'
alias rm='/bin/rm -i'
alias telnet='telnet -8'
alias unlo='export TMOUT=0'
alias xdel='/bin/rm -rf'
END

cat << END >> ~/.profile

if [ -z "$WINDOW" ]; then
PS1='\[\e[1;33m\]\h \[\e[0;36m\]U22\[\e[0;37m\] \A [\[\e[m\]\[\e[0;32m\]\w\[\e[0;37m\]] -\u\[\e[m\]- '
  #stty erase '^?'
else
PS1='\[\e[1;33m\]\h \[\e[0;36m\]U22\[\e[0;37m\] \A [\[\e[m\]\[\e[0;32m\]\w\[\e[0;37m\]] -\u\[\e[m\]- [$WINDOW] '
  #stty erase '^H'
fi

TZ='Asia/Taipei'; export TZ
END

mv /etc/apt/sources.list.d/ceph.list /etc/apt/sources.list.d/ceph.list.disabled  
mv /etc/apt/sources.list.d/pve-enterprise.list /etc/apt/sources.list.d/pve-enterprise.list.disabled

cat << END >> /etc/apt/sources.list

# No scription
deb http://download.proxmox.com/debian bookworm pve-no-subscription
deb http://download.proxmox.com/debian/ceph-quincy bookworm no-subscription
END

apt update
apt -y upgrade

apt -y install parted vim sysstat iotop systemd-timesyncd

curl https://raw.githubusercontent.com/wklken/vim-for-server/master/vimrc -o ~/.vimrc
sed -i 's/set title/" set title/' ~/.vimrc


# 隱藏訂閱警告

# from client PC
# ssh-copy-id -i ~/.ssh/key.pub root@[host-ip]


# Suggest install PVE as ZFS
# modify disk (default local & local-lvm, if install as ZFS no need do this)
## umount /dev/pve/data
## lvremove -y /dev/pve/data
## lvcreate -l +100%FREE -n data pve
## mkfs.ext4 /dev/pve/data
## mkdir /mnt/data
## mount /dev/pve/data /mnt/data
## echo "/dev/pve/data /mnt/data ext4 defaults 0 0" >> /etc/fstab
## Add data to DataCenter > storage 

# mkdir -p ~/.vim/colors
# curl -o solarized.vim https://raw.githubusercontent.com/felix-infohelp/vim-colors-solarized/master/colors/solarized.vim
# mv -f solarized.vim ~/.vim/colors/




