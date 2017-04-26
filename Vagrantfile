# -*- mode: ruby -*-
# vi: set ft=ruby :
#
script = <<SCRIPT
  apt-get install -y ansible ruby
  gem install thor bundler
SCRIPT

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"


  config.vm.provider "virtualbox" do |vb|
    vb.memory = "4096"
  end

  config.vm.define "imimaps.dev" do |box|
    box.vm.network "private_network", ip: "192.168.33.10"
  end

  config.vm.provision "shell", inline: script

  config.vm.provision "ansible_local" do |ansible|
    #ansible.limit = "vagrant"
    ansible.playbook = "./bootstrap_host/playbook.yml"
    ansible.groups = {
      "vagrant" => [
        "imimaps.dev",
      ]
    }
  end
end
