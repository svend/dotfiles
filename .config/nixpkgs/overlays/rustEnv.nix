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

      # rust-analyzer # test are failing

      # rustup

      latest.rustChannels.stable.rust
    ];
  };
}
