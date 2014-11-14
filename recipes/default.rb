#
# Cookbook Name:: platform_modules
# Recipe:: default
#
# Copyright 2014, Vasiliy Tolstov
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

include_recipe "modules"

if !node['platform_modules'].nil?  && !node['platform_modules']['mods'].nil?
  case node['platform_modules']['mods']
  when Array
    node['platform_modules']['mods'].each do |mod_hash|
      modules mod_hash[:name] do
        %w{save autoload options action}.each do |attr|
          send(attr, mod_hash[attr])  if mod_hash[attr]
        end
      end
    end
  when Hash,Mash
    node['platform_modules']['mods'].each do |name, opts|
      modules name do
        %w{save autoload options action actions}.each do |attr|
          if opts[attr]
            if attr == "actions"
              send("action", opts[attr].values)
            else
              send(attr, opts[attr])
            end
          end
        end
      end
    end
  end
end
