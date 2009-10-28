define :cabal_package, :action => :install, :global => true do  
  if params[:action] == :install
    execute "cabal install #{params[:name]}" do
      command "cabal install #{params[:name]}#{' --global' if params[:global]}"
      not_if do
        if params[:global]
          File.directory?("#{node[:haskell][:lib_dir]}/#{params[:name]}")
        else
          File.directory?("#{node[:haskell][:cabal][:package_dir]}/#{params[:name]}")
        end
      end
    end
  end
end