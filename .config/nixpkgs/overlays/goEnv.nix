self: super:
{
  goEnv = with self; super.buildEnv {
    name = "goEnv";
    paths = [
      dep
      glide
      go2nix
      # Use gopls
      # gocode
      # godef
      golangci-lint
      golint
      gopls
      gotools
      pprof
    ] ++ lib.optionals stdenv.isLinux [
      go # https://github.com/NixOS/nixpkgs/issues/56348
    ];
  };
}
