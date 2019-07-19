self: super:
{
  cargo-script = super.callPackage ../pkgs/cargo-script { };
  multi-x509 = super.callPackage ../pkgs/multi-x509 { inherit (super.darwin.apple_sdk.frameworks) Security; };
  rust-scripts = super.callPackage ../pkgs/rust-scripts { inherit (super.darwin.apple_sdk.frameworks) Security; };
}
