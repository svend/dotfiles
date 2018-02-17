self: super:
{
  rustEnv = with self; super.buildEnv {
    name = "rustEnv";
    paths = [
      cargo
      rustc
      # latest.rustChannels.nightly.rust
      # cargo-script  # fails to build
      rustracer
    ];
  };
}
