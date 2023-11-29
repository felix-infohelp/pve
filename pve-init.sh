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

apt update
apt -y upgrade

apt -y install parted vim sysstat iotop systemd-timesyncd

curl https://raw.githubusercontent.com/wklken/vim-for-server/master/vimrc -o ~/.vimrc

# mkdir -p ~/.vim/colors
# curl -o solarized.vim https://raw.githubusercontent.com/felix-infohelp/vim-colors-solarized/master/colors/solarized.vim
# mv -f solarized.vim ~/.vim/colors/
curl https://raw.githubusercontent.com/wklken/vim-for-server/master/vimrc -o ~/.vimrc


# 隱藏訂閱警告






