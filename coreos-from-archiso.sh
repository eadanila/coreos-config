#!/bin/bash

set -exo

TARGET_DEV=$1

if [[ -z $BUTANE_PASSWORD_HASH || -z $BUTANE_TS_AUTH_KEY ]]; then
	if [[ -f butane.env ]]; then
		source butane.env
	else
		echo BUTANE_PASSWORD_HASH or BUTANE_TS_AUTH_KEY not set and butane.env could not be found. Bailing.
		exit -1
	fi
fi

mount -o remount,size=2G /run/archiso/cowspace
pacman -Sy podman fuse-overlayfs --noconfirm

curl https://raw.githubusercontent.com/eadanila/coreos-config/refs/heads/main/config.ign | envsubst > config.ign

podman run --pull=always --privileged --rm \
	-v /dev:/dev -v /run/udev:/run/udev -v .:/data -w /data \
	quay.io/coreos/coreos-installer:release \
	install $TARGET_DEV -i config.ign

reboot
