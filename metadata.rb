maintainer       "Vasiliy Tolstov"
maintainer_email "v.tolstov@selfip.ru"
name             "platform_modules"
license          "Apache 2.0"
description      "Loads/Unloads individual modules via attribute or data bag metadata."
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.1"

%w{ubuntu debian fedora gentoo arch exherbo}.each do |os|
  supports os
end

depends "modules"

recipe "platform_modules", "Processes a list of *mods* (which is emtpy by default) to be installed."
recipe "platform_modules::data_bag", "Fetches an list of *mods* from a data bag item and sets the `node['platform_modules']['mods']` attribute for processing."
