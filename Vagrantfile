$script = <<-SCRIPT
pacman -Sy --noconfirm ansible base-devel git-lfs nano openssh sudo
sudo -u vagrant ansible-galaxy install -r /vagrant/requirements.yml;
SCRIPT

Vagrant.configure("2") do |config|
  config.vm.box = "archlinux/archlinux"

  config.vm.provider "virtualbox" do |v|
    v.memory = 4096
    v.cpus = 4
    v.customize ["modifyvm", :id, "--vram", "64"]
  end

  config.vm.provision "shell", inline: $script

  config.vm.provision "ansible_local" do |ansible|
    ansible.playbook = "playbook.yml"
    ansible.raw_arguments = [
      '--extra-vars', '@vars/ansible.yml'
    ]
  end
end
