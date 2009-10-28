define :haskell_package, :action => :install do  
  if params[:action] == :install
    remote_file "/usr/local/src/#{params[:name]}-#{params[:version]}.tar.gz" do
      source params[:url] || "http://hackage.haskell.org/packages/archive/#{params[:name]}/#{params[:version]}/#{params[:name]}-#{params[:version]}.tar.gz"
      not_if { ::File.exist?("/usr/local/src/#{params[:name]}-#{params[:version]}.tar.gz") }
    end
    
    execute "Expand #{params[:name]}-#{params[:version]} tarball" do
      cwd "/usr/local/src"
      command "tar xzf #{params[:name]}-#{params[:version]}.tar.gz"
      not_if { ::File.directory?("/usr/local/src/#{params[:name]}-#{params[:version]}") }
    end
    
    execute "configure, build and install #{params[:name]}-#{params[:version]}" do
      cwd "/usr/local/src/#{params[:name]}-#{params[:version]}"
      command <<-CMD
        runhaskell Setup configure #{"#{params[:configure_options]} " if params[:configure_options]}#{"--prefix=#{params[:prefix]} " if params[:prefix]} &&
        runhaskell Setup build && 
        runhaskell Setup install
      CMD
      not_if do 
        File.directory?(params[:prefix] ? "#{params[:prefix]}/lib/#{params[:name]}-#{params[:version]}" : "#{node[:haskell][:lib_dir]}/#{params[:name]}-#{params[:version]}") 
      end
    end
  end
end

