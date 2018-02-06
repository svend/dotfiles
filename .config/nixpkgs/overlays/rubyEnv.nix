self: super:
{
  rubyEnv = with super; buildEnv {
    name = "rubyEnv";
    paths = [
      bundler
      ruby
    ];
  };
}
