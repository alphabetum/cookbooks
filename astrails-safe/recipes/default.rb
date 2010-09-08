#
# Cookbook Name:: astrails-safe
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

gem_package "astrails-safe" do
  action :install
end

directory "/etc/astrails-safe" do
  recursive true
  owner "root"
  group "root"
  mode 0755
end

template "/etc/astrails-safe/master.conf" do
  source "master.conf.erb"
  owner "root"
  group "root"
  mode 0755
end

cron "astrails_safe_backup" do
  command "#{node[:languages][:ruby][:gems_dir].match(/(.*)\/lib/)[1]}/bin/astrails-safe /etc/astrails-safe/master.conf" 
  hour "7"
  minute "0"
end