self: super:
{
  rubyEnv = with self; super.buildEnv {
    name = "rubyEnv";
    paths = [
      # bundler # ruby 2.6.4 includes bundler
      ruby
    ];
  };
}
