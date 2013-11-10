VAGRANTFILE_API_VERSION = '2'
SYNCED_FOLDER = ENV['SYNCED_FOLDER'] || "~/projects"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = 'precise32'
  config.vm.box_url = 'http://files.vagrantup.com/precise32.box'
  config.vm.host_name = 'juliobetta'
  config.cache.auto_detect = true
  config.cache.enable_nfs = true

  config.vm.network :private_network, ip: '192.168.33.10'

  config.vm.network :forwarded_port, guest: 80, host: 8080
  config.vm.network :forwarded_port, guest: 3000, host: 3000
  config.vm.network :forwarded_port, guest: 4321, host: 4321

  config.vm.synced_folder SYNCED_FOLDER, "/vagrant", :nfs => true

  config.vm.provider :virtualbox do |vb|
    vb.customize ['modifyvm', :id, '--memory', '1024']
  end

  config.vm.provider :vmware_fusion do |v|
    v.vmx["memsize"] = "1024"
  end

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = 'cookbooks'
    chef.add_recipe 'main'
  end
end
