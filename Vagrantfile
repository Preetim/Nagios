Vagrant.configure('2') do |config|
  config.vm.define :monitor do |config|
    config.vm.box = 'Ubuntu1204_64'
    config.vm.box_url = 'http://files.vagrantup.com/precise64.box'
    config.vm.network :forwarded_port, guest: 80, host: 8084
    config.vm.synced_folder '.','/home/vagrant/nagios'
  end

  config.vm.provision "shell", inline: "./nagios/install_nagios.sh"
end

