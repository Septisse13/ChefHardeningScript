#
# Cookbook:: sshd-server
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

package 'openssh-server'

template '/etc/ssh/sshd_config' do
  source  'sshd_config.erb'
  owner   'root'
  group   'root'
  mode    '0644'
  variables(
    'sshd_ip_listen': node['sshd-server']['ip_listen'],
    'sshd_admins': node['sshd-server']['admins']
    )
end

include_recipe "sshd-server::firewall"

service 'ssh' do
  action [:enable, :restart]
end
