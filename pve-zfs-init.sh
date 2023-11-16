#!/bin/bash

# Check zfs status
zpool status -v

# Check ZFS CLI
zpool scrub <zfs name>  #在背景檢查
zpool scrub -S <zfs name>

# zfs發送通知
vi /etc/zfs/zed.d/zed.rc
ZED_EMAIL_ADDR="felix@gmail.com"
ZED_NOTIFY_INTERVAL_SECS=3600

ZED_NOTIFY_VERBOSE=1  # 1 表示任何zfs動作一律發email

# 設定排程
echo "1 23 * * * root /usr/sbin/zpool scrub <zfs namw>"

# 如果硬碟故障，更換硬碟後要做 resilver動作
apool resilver <zfs name>


