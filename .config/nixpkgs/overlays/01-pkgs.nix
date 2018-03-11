self: super:
{
  cargo-script = super.callPackage ../pkgs/cargo-script { };
  errcheck = super.callPackage ../pkgs/errcheck { };
}
