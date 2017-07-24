#
# Cookbook:: ossec_agentless
# Recipe:: default
#
# Copyright:: 2017, Armando Uch, All Rights Reserved.

include_recipe "ossec_agentless::repositories"
include_recipe "ossec_agentless::postfix"

package %w(ossec-hids ossec-hids-server)

cookbook_file '/etc/profile.d/ossec.sh' do
  source 'ossec.sh'
  owner 'root'
  group 'root'
  mode '0644'
end

bash 'config ossec-init' do
  user 'root'
  cwd '/tmp'
  code <<-EOH
  sed -i "s/server/local/g" /etc/ossec-init.conf
  EOH
  not_if 'grep -w local /etc/ossec-init.conf'
end

template '/var/ossec/etc/ossec-server.conf' do
  source 'ossec-server.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
  variables({
  	:white_list => node['ossec']['white_list'],
  	:directories => node['ossec']['directories_to_check'],
  	:email_to => node['ossec']['email_to'],
  	:smtp_server => node['ossec']['smtp_server'],
  	:email_from => node['ossec']['email_from'],
  	:email_alerts => node['ossec']['email_alerts']
	})
end

execute 'stop-ossec' do
  command '/var/ossec/bin/ossec-control stop'
  action :run
  only_if 'ls /var/ossec/var/run/*.pid'
end

execute 'start-ossec' do
  command '/var/ossec/bin/ossec-control start'
  action :run
  not_if 'ls /var/ossec/var/run/*.pid'
end

execute 'enable ossec-hids' do
  command '/sbin/chkconfig ossec-hids on'
  action :run
end
