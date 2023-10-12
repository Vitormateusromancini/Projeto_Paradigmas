{ pkgs }: {
    deps = [
        (pkgs.haskellPackages.ghcWithPackages (pkgs: with pkgs; [
           scotty wai-extra  random random-shuffle

        ]))       
        pkgs.haskellPackages.ghc
        pkgs.haskell-language-server
    ];
}
