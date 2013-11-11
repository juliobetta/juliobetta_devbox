include_recipe 'apt'
include_recipe 'openssl'

node.set['platform'] = 'ubuntu'

# sudo
node.set["authorization"]["sudo"] = {
  :users => ["vagrant"],
  :passwordless => true
}

# Mysql
node.set['mysql'] = {
  :server_root_password => '',
  :server_repl_password => '',
  :server_debian_password => '',
  :allow_remote_root => true,
  :bind_address => '*',

  :client => {
    :packages => ['libmysqlclient-dev']
  }
}

# rvm
node.set['rvm']['installer_url'] = "https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer"
node.set['rvm']['user_installs'] = [ {
  :user => 'vagrant',
  :install_rubies => true,
  :default_ruby => 'ruby-2.0.0-p247',
  :rubies => ['ruby-1.9.3-p448']
} ]
node.set['rvm']['user_install_rubies'] = true
node.set['rvm']['vagrant'] = {
  :system_chef_solo => '/usr/local/bin/chef-solo'
}

# Mongo DB
node.set[:mongodb] = {
  :version => "2.4.0"
}

include_recipe 'sudo'
include_recipe 'ark'
include_recipe 'build-essential'
include_recipe 'mysql::server'
include_recipe 'mysql::client'
include_recipe 'mongodb::10gen_repo'
include_recipe 'mongodb::default'
include_recipe 'nodejs'
include_recipe 'nodejs::npm'

# Packages
%w(git-core subversion curl htop).each do |package_name|
  package package_name do
    action :install
  end
end

include_recipe 'rvm::vagrant'
include_recipe 'rvm::user'

# Dotfiles
git "/home/vagrant/.yadr" do
  user "vagrant"
  group "vagrant"
  repository "https://github.com/akitaonrails/dotfiles.git"
  reference "master"
  action :checkout
end

