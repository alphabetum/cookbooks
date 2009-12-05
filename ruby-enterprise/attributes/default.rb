ruby_enterprise_edition Mash.new unless attribute?("ruby_enterprise_edition")

case platform
when "ubuntu"
  ruby_enterprise_edition[:version] = '1.8.7-2009.10_i386'
  ruby_enterprise_edition[:package_name] = "ruby-enterprise_#{ruby_enterprise_edition[:version]}.deb"
  ruby_enterprise_edition[:install_path] = "/usr/local"
  
  # note: the id after download.php is dependent on the package
  ruby_enterprise_edition[:url] = "http://rubyforge.org/frs/download.php/66164/#{ruby_enterprise_edition[:package_name]}"
else
  ruby_enterprise_edition[:version] = '1.8.7-20090928' unless ruby_enterprise_edition.has_key?(:version)
  ruby_enterprise_edition[:install_path] = "/opt/ruby-enterprise-#{ruby_enterprise_edition[:version]}" unless ruby_enterprise_edition.has_key?(:install_path)
  # note: the id after download.php is dependent on the package
  ruby_enterprise_edition[:url] = "http://rubyforge.org/frs/download.php/64475/ruby-enterprise-#{ruby_enterprise_edition[:version]}.tar.gz"
  ruby_enterprise_edition[:cow_friendly] = %Q[#{ruby_enterprise_edition[:install_path]}/bin/ruby -e "exit 1 unless GC.respond_to?(:copy_on_write_friendly=)"]
end

languages[:ruby][:gems_dir] = "#{ruby_enterprise_edition[:install_path]}/lib/ruby/gems/1.8"
languages[:ruby][:ruby_bin] = "#{ruby_enterprise_edition[:install_path]}/bin/ruby"