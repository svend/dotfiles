self: super:
{
  goEnv = with self; super.buildEnv {
    name = "goEnv";
    paths = [
      dep
      errcheck
      glide
      go2nix
      gocode
      godef
      golangci-lint
      golint
      gotools
    ] ++ lib.optionals stdenv.isLinux [
      go # https://github.com/NixOS/nixpkgs/issues/56348
    ];
  };
}
