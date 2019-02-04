#
# Cookbook:: apt-client
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

directory '/etc/apt/repo-keys' do
  owner 'root'
  group 'root'
  mode '0644'
  recursive true
  action :create
end

include_recipe "apt-client::debian"

include_recipe "apt-client::firewall"
