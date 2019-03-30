self: super:
{
  rustEnv = with self; super.buildEnv {
    name = "rustEnv";
    paths = [
      cargo
      rustc
      rustfmt

      # gcc
      # gnumake
      # binutils-unwrapped

      cargo-script
      rustracer

      # rustup

      # latest.rustChannels.nightly.rust
      # rustChannels.nightly.rust
    ];
  };
}
