self: super:
{
  goEnv = with self; super.buildEnv {
    name = "goEnv";
    paths = [
      dep
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
