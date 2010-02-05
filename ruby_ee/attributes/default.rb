ruby_ee Mash.new unless attribute?("ruby_ee")

case platform
when "ubuntu"
  ruby_ee[:version] = '1.8.7-2009.10_i386'
  ruby_ee[:package_name] = "ruby-enterprise_#{ruby_ee[:version]}.deb"
  ruby_ee[:install_path] = "/usr/local"
  
  # note: the id after download.php is dependent on the package
  ruby_ee[:url] = "http://rubyforge.org/frs/download.php/66164/#{ruby_ee[:package_name]}"
else
  ruby_ee[:version] = '1.8.7-20090928' unless ruby_ee.has_key?(:version)
  ruby_ee[:install_path] = "/opt/ruby-enterprise-#{ruby_ee[:version]}" unless ruby_ee.has_key?(:install_path)
  # note: the id after download.php is dependent on the package
  ruby_ee[:url] = "http://rubyforge.org/frs/download.php/64475/ruby-enterprise-#{ruby_ee[:version]}.tar.gz"
  ruby_ee[:cow_friendly] = %Q[#{ruby_ee[:install_path]}/bin/ruby -e "exit 1 unless GC.respond_to?(:copy_on_write_friendly=)"]
end

languages[:ruby][:gems_dir] = "#{ruby_ee[:install_path]}/lib/ruby/gems/1.8"
languages[:ruby][:ruby_bin] = "#{ruby_ee[:install_path]}/bin/ruby"