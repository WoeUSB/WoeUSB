# -*- mode: ruby -*-
# vi: set ft=ruby :
# Vagrant configuration file
# Reference:
#   - Vagrantfile - Vagrant by HashiCorp
#     https://www.vagrantup.com/docs/vagrantfile/
# Copyright © 2021 WoeUSB project contributors
# SPDX-License-Identifier: GPL-3.0-or-later
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  # https://www.vagrantup.com/docs/virtualbox/configuration.html
  config.vm.provider "virtualbox" do |v|
    # Customize the amount of memory on the VM
    # Use too much may causes host system thrashing
    v.memory = "512"

    # Optimize for 4 CPU cores (possibly with 8 CPU threads) notebooks
    # The sane value is how many physical cores your system has
    v.cpus = 4

    # Use VirtIO NIC for better performance
    # https://www.virtualbox.org/manual/ch08.html#vboxmanage-modifyvm-networking
    v.default_nic_type = "virtio"
  end

  # Shared-folder configuration
  # the vagrant file residing folder is mapped/copied into /vagrant
  config.vm.synced_folder ".",
    "/vagrant",
    owner: "vagrant",
    group: "vagrant",
    mount_options: [
      # Avoid some program errored due to excessive access from `other`
      "fmode=0770",
      "dmode=0770"
    ]

  config.vm.define "slackware-14-2" do |slackware_14_2|
    # Customize in-Virtualbox VM name
    slackware_14_2.vm.provider "virtualbox" do |v|
      v.name = "woeusb.slackware-14.2"
    end
    slackware_14_2.vm.box = "hector-vido/slackware-14.2"

    # Customize in-VM hostname
    slackware_14_2.vm.hostname = "woeusb-slackware-14-2"

    # Port forwarding configuration
    slackware_14_2.vm.network "forwarded_port", guest: 22, host: 2222, host_ip: "127.0.0.1", id: "ssh", auto_correct: true
    #slackware_14_2.vm.provision "shell", path: "provision-slackware-14-2.bash"

    # This box doesn't support synced folders whatsoever
    slackware_14_2.vm.synced_folder ".", "/vagrant", disabled: true
  end
end
