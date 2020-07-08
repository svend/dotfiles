# TODO: Remove this overlay once commit is merged to master
# https://github.com/NixOS/nixpkgs/pull/91347
# git branch -a --contains 81a8b76b3aadd1c73122cc076d44796fbf9a112f
self: super:
{
  go_1_14 = with super; go_1_14.overrideAttrs (old: rec {
    postConfigure = ''
      export GOCACHE=$TMPDIR/go-cache
      # this is compiled into the binary
      export GOROOT_FINAL=$out/share/go
      export PATH=$(pwd)/bin:$PATH
      ${stdenv.lib.optionalString (stdenv.buildPlatform != stdenv.targetPlatform) ''
        # Independent from host/target, CC should produce code for the building system.
        # We only set it when cross-compiling.
        export CC=${buildPackages.stdenv.cc}/bin/cc
      ''}
      ulimit -a
    '';
  });
}
