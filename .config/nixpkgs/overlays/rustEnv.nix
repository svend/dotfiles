self: super:
{
  rustEnv = with self; super.buildEnv {
    name = "rustEnv";
    paths = [
      # cargo
      # rustc
      # rustfmt

      # gcc
      # gnumake
      # binutils-unwrapped

      # rustup

      cargo-edit
      latest.rustChannels.stable.rust
      rust-analyzer
    ];
  };
}
