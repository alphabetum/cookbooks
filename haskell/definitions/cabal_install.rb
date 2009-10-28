define :cabal_install, :action => :install do
  if params[:action] == :install
    remote_file "/usr/local/src/cabal-install-#{node[:haskell][:cabal][:version]}.tar.gz" do
      source "http://hackage.haskell.org/packages/archive/cabal-install/#{node[:haskell][:cabal][:version]}/cabal-install-#{node[:haskell][:cabal][:version]}.tar.gz"
      not_if { ::File.exist?("/usr/local/src/cabal-install-#{node[:haskell][:cabal][:version]}.tar.gz") }
    end
    
    execute "Expand cabal-install-#{node[:haskell][:cabal][:version]} tarball" do
      cwd "/usr/local/src"
      command "tar xzf cabal-install-#{node[:haskell][:cabal][:version]}.tar.gz"
      not_if { ::File.directory?("/usr/local/src/cabal-install-#{node[:haskell][:cabal][:version]}") }
    end
    
    execute "bootstrap cabal-install-#{node[:haskell][:cabal][:version]}" do
      cwd "/usr/local/src/cabal-install-#{node[:haskell][:cabal][:version]}"
      command "./bootstrap.sh"
      not_if do 
        File.directory?(File.expand_path("~/.cabal"))
      end
    end
    
    link "/usr/bin/cabal" do
      to File.expand_path("~/.cabal/bin/cabal")
      not_if do 
        File.symlink?("/usr/bin/cabal")
      end
    end
    
    execute "cabal update" do
      command "cabal update"
    end
  end
end