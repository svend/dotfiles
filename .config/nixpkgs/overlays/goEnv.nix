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
      godep
      godef
      goimports
      golint
    ];
  };
}
