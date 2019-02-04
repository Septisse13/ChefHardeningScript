#
# Cookbook:: ntpd-server
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

package 'ntp'

service 'ntp' do
  action [:enable, :stop]
end

user 'ntp' do
  comment   'This user is dedicated to execution of ntpd'
  shell     '/bin/false'
  home      ''
  system    true
end

template '/etc/ntp.conf' do
  source  'ntp.conf.erb'
  owner   'ntp'
  group   'ntp'
  mode    '0644'
  variables(
    'ntp_ip_listen': "#{node['ntpd-client']['ip_listen']}",
    'ntp_servers': node['ntpd-client']['servers']
    )
end

include_recipe "ntpd-client::firewall"

service 'ntp' do
  action [:enable, :start]
end
