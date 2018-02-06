self: super:
with super.pkgs;
{
  rubyEnv = pkgs.buildEnv {
    name = "rubyEnv";
    paths = [
      bundler
      ruby
    ];
  };
}
