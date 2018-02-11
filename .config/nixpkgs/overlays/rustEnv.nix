self: super:
{
  rustEnv = with self; super.buildEnv {
    name = "rustEnv";
    paths = [
      cargo
      # cargo-script  # fails to build
      rustracer
      rustc
    ];
  };
}
