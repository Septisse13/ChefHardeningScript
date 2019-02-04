#cookbook_file '/etc/apt/repo-keys/debian.gpg' do
#  source 'debian.gpg'
#  owner 'root'
#  group 'root'
#  mode '0644'
#  action :create
#end

apt_repository 'debian' do
  #uri "http://#{node[:apt-client][:mirror_uri]}/#{node[:platform]}"
  uri "http://#{node['apt-client']['mirror_uri']}/#{node['platform']}/"
  if node[:hostnamectl][:operating_system].include?("jessie")
    distribution "jessie"
  end
  components ['main', 'contrib', 'non-free']
#  key '/etc/apt/repo-keys/debian.gpg'
  action :add
end
