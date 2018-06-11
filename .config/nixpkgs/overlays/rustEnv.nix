self: super:
{
  rustEnv = with self; super.buildEnv {
    name = "rustEnv";
    paths = [
      # cargo
      # rustfmt
      # rustc
      # rustup
      rustChannels.nightly.rust
      gcc
      # latest.rustChannels.nightly.rust
      cargo-script
      rustracer
    ];
  };
}
