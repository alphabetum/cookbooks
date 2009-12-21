#
# Cookbook Name:: sphinx
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
case node[:platform]
when "ubuntu"
  remote_file "/usr/local/src/sphinx-#{node[:sphinx][:version]}.tar.gz" do
    source node[:sphinx][:url]
    not_if { ::File.exist?("/usr/local/src/sphinx-#{node[:sphinx][:version]}.tar.gz") }
  end
  
  execute "Expand sphinx tarball" do
    cwd "/usr/local/src"
    command "tar xzf sphinx-#{node[:sphinx][:version]}.tar.gz"
    not_if { ::File.directory?("/usr/local/src/sphinx-#{node[:sphinx][:version]}") }
  end
  
  execute "Make and install sphinx" do
    cwd "/usr/local/src/sphinx-#{node[:sphinx][:version]}"
    command "./configure --prefix=/usr/local && make && sudo make install"
    not_if { ::File.exist?("/usr/local/bin/indexer") }
  end
end