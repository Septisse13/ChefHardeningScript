#
# Cookbook:: ntpd-server
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

include_recipe 'simple_iptables'

#package 'ntp'

template '/home/user/ntp.conf' do
  source  'ntp.conf.erb'
  owner   'user'
  group   'user'
  mode    '0644'
  variables(
    'ntp_ip_listen': '192.168.51.51',
    'ntp_servers': %w(toto tata)
    )
end

simple_iptables_rule "out-ntp" do
  table "nat"
  direction "OUTPUT"
  rule "-m owner ntp --proto udp --dport 123 --sport 53 -m state --state NEW,ESTABLISHED"
  jump "ACCEPT"
end

simple_iptables_rule "in-ntp" do
  table "nat"
  direction "INPUT"
  rule "ntp --proto udp --dport 123 --sport 53 -m state --state ESTABLISHED"
  jump "ACCEPT"
end
#
#service 'ntp' do
#  support status: true
#  action [:enable, :start]
#end
