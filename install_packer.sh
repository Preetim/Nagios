#!/bin/bash
sudo apt-get install unzip
if [ ! -d "packer" ]; then
  wget -O packer.zip https://dl.bintray.com/mitchellh/packer/0.4.0_linux_amd64.zip
  mkdir packer
  unzip packer.zip -d packer/
fi