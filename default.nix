let 
  # managed using nix-thunk
  pkgs = import ./dep/nixpkgs {};
  compiler = pkgs.haskellPackages;

  # Sources
  src = {
  };
  hoogle = (compiler.override {
    overrides = self: super: with pkgs.haskell.lib; {
      ghc = super.ghc // { withPackages = super.ghc.withHoogle; };
      ghcWithPackages = self.ghc.withPackages;
    };
  }).ghcWithPackages (p: with p; [
    text
    aeson
    warp
    http-client 
    lens
    semigroups
    monad-logger
    optparse-applicative
    profunctors
    bifunctors
    exceptions
    file-embed
    mtl
    tagged
    containers
    shower
    lsp
  ]);
in 
  pkgs.writeShellScriptBin "hoogleverse" "${hoogle}/bin/hoogle server --local $*"
