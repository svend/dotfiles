self: super:
{
  gotools = with super; gotools.overrideAttrs (old: rec {
    # Exclude bundle and link, which conflict with installed packages
    excludedPackages = "\\("
      + stdenv.lib.concatStringsSep "\\|" ([ "bundle" "link" "testdata" ] ++ stdenv.lib.optionals (stdenv.lib.versionAtLeast go.meta.branch "1.5") [ "vet" "cover" ])
      + "\\)";
  });
}
