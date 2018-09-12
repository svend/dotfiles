self: super:
{
  goEnv = with self; super.buildEnv {
    name = "goEnv";
    paths = [
      dep
      errcheck
      glide
      go
      gocode
      godef
      # goimports # included in gotools
      golint
      # gotools # nix-env --set-flag priority 6 goEnv
    ];
  };
}
