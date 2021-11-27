$script = <<-SCRIPT
pacman -Sy --noconfirm base-devel git-lfs nano openssh sudo
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
    ansible.config_file = "vagrant-ansible.cfg"

    ansible.playbook = "main.yml"
    ansible.extra_vars = "vars/vagrant.yml"

    ansible.galaxy_role_file = "requirements.yml"
  end
end
