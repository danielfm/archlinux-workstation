Vagrant.configure("2") do |config|
  config.vm.box = "archlinux/archlinux"

  config.vm.provider "virtualbox" do |v|
    v.customize ["modifyvm", :id, "--vram", "64"]

    v.memory = 4096
    v.cpus = 4
  end

  config.vm.provision "shell" do |s|
    s.inline = "pacman -Syu --noconfirm base-devel git-lfs"
  end

  config.vm.provision "ansible_local" do |ansible|
    ansible.playbook = "playbook.yml"
    ansible.raw_arguments = [
      '--extra-vars', '@vars/ansible.yml'
    ]
  end
end
