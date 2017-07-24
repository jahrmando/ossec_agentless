#
# Cookbook:: ossec_agentless
# Recipe:: repositories
#
# Copyright:: 2017, Armando Uch, All Rights Reserved.

execute 'clean-yum-cache' do
  command 'yum clean all'
  action :nothing
end

execute "install repo atomicorp" do
  cwd Chef::Config[:file_cache_path]
  environment(
    'AT_VERSION' => '1.0-21'
    )
  command "rpm -Uvh https://updates.atomicorp.com/channels/atomic/centos/7/x86_64/RPMS/atomic-release-${AT_VERSION}.el7.art.noarch.rpm"
  not_if "yum repolist | grep atomic"
  notifies :run, 'execute[clean-yum-cache]', :immediately
end
