#
# Cookbook Name:: haskell
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

%W[
  ghc6 libghc6-xhtml-dev libghc6-mtl-dev libghc6-network-dev
].each do |p|
  package p do
    action :install
  end
end

cabal_install do
  action :install
end