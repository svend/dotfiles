self: super:
{
  cargoscript = super.callPackage ../pkgs/cargo-script { };
  errcheck = super.callPackage ../pkgs/errcheck { };
}
