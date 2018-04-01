self: super:
{
  rustEnv = with self; super.buildEnv {
    name = "rustEnv";
    paths = [
      cargo
      rustfmt
      rustc
      # latest.rustChannels.nightly.rust
      cargo-script
      rustracer
    ];
  };
}
