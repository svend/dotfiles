self: super:
{
  rustEnv = with self; super.buildEnv {
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
