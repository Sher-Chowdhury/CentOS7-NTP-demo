# -*- mode: ruby -*-
# vi: set ft=ruby :


# http://stackoverflow.com/questions/19492738/demand-a-vagrant-plugin-within-the-vagrantfile
# not using 'vagrant-vbguest' vagrant plugin because now using bento images which has vbguestadditions preinstalled.
required_plugins = %w( vagrant-hosts vagrant-share vagrant-vbox-snapshot vagrant-host-shell vagrant-triggers vagrant-reload )
plugins_to_install = required_plugins.select { |plugin| not Vagrant.has_plugin? plugin }
if not plugins_to_install.empty?
  puts "Installing plugins: #{plugins_to_install.join(' ')}"
  if system "vagrant plugin install #{plugins_to_install.join(' ')}"
    exec "vagrant #{ARGV.join(' ')}"
  else
    abort "Installation of one or more plugins has failed. Aborting."
  end
end



Vagrant.configure(2) do |config|
  config.vm.define "ntp_server" do |ntp_server|
    ntp_server.vm.box = "bento/centos-7.4"
    ntp_server.vm.hostname = "ntp-server.example.com"
    # https://www.vagrantup.com/docs/virtualbox/networking.html
    ntp_server.vm.network "private_network", ip: "10.2.4.10", :netmask => "255.255.255.0", virtualbox__intnet: "intnet2"

    ntp_server.vm.provider "virtualbox" do |vb|
      vb.gui = true
      vb.memory = "1024"
      vb.cpus = 2
      vb.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
      vb.name = "centos7_ntp_server"
    end

    ntp_server.vm.provision "shell", path: "scripts/install-rpms.sh", privileged: true
    ntp_server.vm.provision "shell", path: "scripts/setup_ntp_server.sh", privileged: true
  end


  config.vm.define "ntp_peer" do |ntp_peer|
    ntp_peer.vm.box = "bento/centos-7.4"
    ntp_peer.vm.hostname = "ntp-peer.example.com"
    ntp_peer.vm.network "private_network", ip: "10.2.4.12", :netmask => "255.255.255.0", virtualbox__intnet: "intnet2"

    ntp_peer.vm.provider "virtualbox" do |vb|
      vb.gui = true
      vb.memory = "1024"
      vb.cpus = 2
      vb.name = "centos7_ntp_peer"
    end

    ntp_peer.vm.provision "shell", path: "scripts/install-rpms.sh", privileged: true
    ntp_peer.vm.provision "shell", path: "scripts/setup_ntp_peer.sh", privileged: true
  end

  config.vm.provision :hosts do |provisioner|
    provisioner.add_host '10.2.4.10', ['ntp-server.example.com']
    provisioner.add_host '10.2.4.11', ['ntp-peer.example.com']
  end

end