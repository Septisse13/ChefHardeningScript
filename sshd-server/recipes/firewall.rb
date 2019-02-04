iptables_rule "out-sshd-server" do
  lines     "-A OUTPUT "\
            "-o #{node['sshd-server']['iface']} "\
            "-s #{node['sshd-server']['ip_listen']} "\
            "--proto tcp --sport 22 "\
            "-m state --state ESTABLISHED "\
            "-j ACCEPT"
end

# TODO : specify source IP
iptables_rule "in-sshd-server" do
  lines     "-A INPUT "\
            "-i #{node['sshd-server']['iface']} "\
            "-d #{node['sshd-server']['ip_listen']} "\
            " --proto tcp --dport 22 "\
            "-m state --state NEW,ESTABLISHED "\
            "-j ACCEPT"
end
