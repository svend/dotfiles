self: super:
{
  goEnv = with self; super.buildEnv {
    name = "goEnv";
    paths = [
      dep
      errcheck
      glide
      # go
      go2nix
      gocode
      godef
      # goimports # included in gotools
      golint
      # gotools # FTB on darwin 2019-03-26
    ];
  };
}
