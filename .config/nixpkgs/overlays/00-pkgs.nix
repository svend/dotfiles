self: super:
{
  gopls = super.callPackage ../pkgs/gopls { inherit (super.darwin.apple_sdk.frameworks) Security; };
  multi-x509 = super.callPackage ../pkgs/multi-x509 { inherit (super.darwin.apple_sdk.frameworks) Security; };
  rust-scripts = super.callPackage ../pkgs/rust-scripts { inherit (super.darwin.apple_sdk.frameworks) Security; };
  scriptisto = super.callPackage ../pkgs/scriptisto { inherit (super.darwin.apple_sdk.frameworks) Security; };
}
