iptables_rule "out-ntpd-client" do
  lines     "-A OUTPUT "\
            "-o #{node['ntpd-client']['iface']} "\
            "-s #{node['ntpd-client']['ip_listen']} "\
            "--proto udp --sport 123 --dport 123 "\
            "-m state --state NEW,ESTABLISHED "\
            "-j ACCEPT"
end

iptables_rule "in-ntpd-client" do
  lines     "-A INPUT "\
            "-i #{node['ntpd-client']['iface']} "\
            "-d #{node['ntpd-client']['ip_listen']} "\
            "--proto udp --sport 123 --dport 123 "\
            "-m state --state ESTABLISHED "\
            "-j ACCEPT"
end
