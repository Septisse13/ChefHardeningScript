#simple_iptables_rule "out-apt-client" do
#  table     "filter"
#  direction "OUTPUT"
#  rule "--proto tcp"
##  rule      "-o #{node['apt-client']['iface']} "\
##            "-s #{node['apt-client']['ip_listen']} "
##            "--proto tcp --dport 80"\
##            "-m state --state NEW,ESTABLISHED"
#  jump      "ACCEPT"
#end
#
#simple_iptables_rule "in-apt-client" do
#  table     "filter"
#  direction "INPUT"
#  rule "--proto tcp"
##  rule      "-i #{node['apt-client']['iface']} "\
##            "-d #{node['apt-client']['ip_listen']} "\
##            "--proto tcp --sport 80 "\
##            "-m state --state ESTABLISHED"
#  jump      "ACCEPT"
#end

iptables_rule 'out-apt-client' do
    lines "-A OUTPUT -o #{node['apt-client']['iface']} "\
          "-s #{node['apt-client']['ip_listen']} "\
          "--proto tcp --dport 80 "\
          "-m state --state NEW,ESTABLISHED "\
          "-j ACCEPT"
end

iptables_rule 'in-apt-client' do
    lines "-A INPUT  -i #{node['apt-client']['iface']} "\
          "-d #{node['apt-client']['ip_listen']} "\
          "--proto tcp --sport 80 "\
          "-m state --state ESTABLISHED "\
          "-j ACCEPT"
end
