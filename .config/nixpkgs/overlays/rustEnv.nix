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

      # cargo-script
      # rustracer # use Rust Language Server (rls), provided by rustup

      # rustup

      latest.rustChannels.stable.rust
    ];
  };
}
