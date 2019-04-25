self: super:
{
    gotools = with super; gotools.overrideAttrs (old: rec {
        # Do not install bundle
        excludedPackages = "\\("
          + stdenv.lib.concatStringsSep "\\|" ([ "bundle" "testdata" ] ++ stdenv.lib.optionals (stdenv.lib.versionAtLeast go.meta.branch "1.5") [ "vet" "cover" ])
          + "\\)";
        });
}
