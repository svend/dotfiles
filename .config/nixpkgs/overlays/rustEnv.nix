self: super:
{
  rustEnv = with super; buildEnv {
    name = "rustEnv";
    paths = [
      cargo
      rustc
    ];
    buildInputs = [
      cargo
      rustc
    ];
  };
}
