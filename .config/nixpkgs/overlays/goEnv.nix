self: super:
{
  goEnv = with self; super.buildEnv {
    name = "goEnv";
    paths = [
      go # https://github.com/NixOS/nixpkgs/issues/56348

      # Legacy dependency management tools
      dep
      glide

      # Development tools
      golangci-lint
      golint
      gopls # replaces gocode and godef
      gotools # godoc (doc web server), goimports

      go2nix
      pprof
    ];
  };
}
