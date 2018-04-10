self: super:
{
  black = super.callPackage ../pkgs/black { };
  cargo-script = super.callPackage ../pkgs/cargo-script { };
  errcheck = super.callPackage ../pkgs/errcheck { };
}
