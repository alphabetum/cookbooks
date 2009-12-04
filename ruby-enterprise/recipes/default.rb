#
# Cookbook Name:: ruby-enterprise
# Recipe:: default
#
# Copyright 2009, Kyakia LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

###
# Install and configure Ruby Enterprise Edition
# Originally from http://gist.github.com/138430
##
 
# TODO: A future release of Chef should have a source_package resource to handle installs like this
 
%w(zlib1g-dev libssl-dev libreadline5-dev).each do |p|
  package p
end

remote_file "/usr/local/src/ruby-enterprise-#{node[:ruby_enterprise_edition][:version]}.tar.gz" do
  source node[:ruby_enterprise_edition][:url]
  not_if { ::File.exist?("/usr/local/src/ruby-enterprise-#{node[:ruby_enterprise_edition][:version]}.tar.gz") }
end
 
execute "Expand ruby enterprise edition tarball" do
  cwd "/usr/local/src"
  command "tar xzf ruby-enterprise-#{node[:ruby_enterprise_edition][:version]}.tar.gz"
  not_if { ::File.directory?("/usr/local/src/ruby-enterprise-#{node[:ruby_enterprise_edition][:version]}") }
end
 
execute "Install ruby enterprise edition" do
  cwd "/usr/local/src/ruby-enterprise-#{node[:ruby_enterprise_edition][:version]}"
  command "./installer --auto=#{node[:ruby_enterprise_edition][:install_path]} && echo '#{node[:ruby_enterprise_edition][:version]}' > /etc/ruby-enterprise-version"
  not_if {
    ::File.exists?('/etc/ruby-enterprise-version') &&
    ::File.read('/etc/ruby-enterprise-version').chomp == node[:ruby_enterprise_edition][:version] && 
    ::File.exist?("#{node[:ruby_enterprise_edition][:install_path]}/bin/ruby") && 
    system(node[:ruby_enterprise_edition][:cow_friendly])
  }
end
 
%w(ruby rake irb gem).each do |cmd|
  link "/usr/bin/#{cmd}" do
    to "#{node[:ruby_enterprise_edition][:install_path]}/bin/#{cmd}"
  end
end

execute "update rubygems" do
  command "gem update --system"
end

%W[ ohai chef ].each do |g|
  gem_package g do
    source "http://gems.opscode.com"
    action :install
  end
end

File.open('/etc/environment', 'r+') do |f|
  lines = f.readlines
  lines.each do |l|
    unless l.match('ruby-enterprise')
      l.gsub!(%r{PATH=\"/usr/local}, "PATH=\"#{node[:ruby_enterprise_edition][:install_path]}/bin:/usr/local")
    end
  end
  f.pos = 0
  f.print lines
  f.truncate(f.pos)
end