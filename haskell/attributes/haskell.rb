haskell Mash.new unless attribute?("haskell")

haskell[:lib_dir] = "/usr/local/lib"
haskell[:cabal] = {} unless haskell.has_key?(:cabal)
haskell[:cabal][:version] = "0.6.2"
haskell[:cabal][:dir] = "~/.cabal"
haskell[:cabal][:package_dir] = "#{haskell[:cabal][:dir]}/packages/hackage.haskell.org/" unless haskell[:cabal].has_key?(:package_dir)