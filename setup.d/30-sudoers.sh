#!/usr/bin/env bash

rm /etc/sudoers.d/90-cloud-init-users
echo "%wheel ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/wheel

restorecon -rv /etc/sudoers.d
