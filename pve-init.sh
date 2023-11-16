#!/bin/bash
# 

echo "alias ll='ls -lah'" >> /etc/profile
echo "export LC_ALL='en_US.UTF-8'" >> /etc/profile

mv /etc/apt/sources.list.d/ceph.list /etc/apt/sources.list.d/ceph.list.disabled  
mv /etc/apt/sources.list.d/pve-enterprise.list /etc/apt/sources.list.d/pve-enterprise.list.disabled

cat << END >> /etc/apt/sources.list

# No scription
deb http://download.proxmox.com/debian bookworm pve-no-subscription
deb http://download.proxmox.com/debian/ceph-quincy bookworm no-subscription
END

# modify disk (default local & local-lvm, if install as ZFS no need do this)
umount /dev/pve/data
lvremove -y /dev/pve/data
lvcreate -l +100%FREE -n data pve
mkfs.ext4 /dev/pve/data
mkdir /mnt/data
mount /dev/pve/data /mnt/data
echo "/dev/pve/data /mnt/data ext4 defaults 0 0" >> /etc/fstab
## Add data to DataCenter > storage 

apt update
apt -y upgrade

apt -y install vim sysstat iotop
cat << END > ~/.vimrc
set ls=2
set statusline=[%{expand('%:p')}]\ [%{strlen(&fenc)?&fenc:&enc},\ %{&ff},\ %{strlen(&filetype)?&filetype:'plain'}]\ %{FileSize()}%{IsBinary()}%=%c,%l/%L\ [%3p%%]
function IsBinary()
    if (&binary == 0)
        return ""
    else
        return "[Binary]"
    endif
endfunction

function FileSize()
    let bytes = getfsize(expand("%:p"))
    if bytes <= 0
        return "[Empty]"
    endif
    if bytes < 1024
        return "[" . bytes . "B]"
    elseif bytes < 1048576
        return "[" . (bytes / 1024) . "KB]"
    else
        return "[" . (bytes / 1048576) . "MB]"
    endif
endfunction

syntax enable
set nohlsearch
set backspace=2
set noautoindent
set ruler
set showmode
set background=dark
colorscheme solarized
END

mkdir -p ~/.vim/colors
curl -o solarized.vim https://raw.githubusercontent.com/felix-infohelp/vim-colors-solarized/master/colors/solarized.vim
mv -f solarized.vim ~/.vim/colors/

# 隱藏訂閱警告






