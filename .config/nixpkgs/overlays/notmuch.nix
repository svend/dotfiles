self: super:
{
  # 2018-02-02 Fix "couldn't find libtalloc in nix store"
  # https://github.com/NixOS/nixpkgs/pull/34577
  notmuch = super.notmuch.overrideAttrs (old: rec {
    preFixup = super.lib.optionalString super.stdenv.isDarwin ''
      set -e

      die() {
        >&2 echo "$@"
        exit 1
      }

      prg="$out/bin/notmuch"
      lib="$(find "$out/lib" -name 'libnotmuch.?.dylib')"

      [[ -s "$prg" ]] || die "couldn't find notmuch binary"
      [[ -s "$lib" ]] || die "couldn't find libnotmuch"

      badname="$(otool -L "$prg" | awk '$1 ~ /libtalloc/ { print $1 }')"
      goodname="$(find "${old.talloc}/lib" -name 'libtalloc.*.*.*.dylib')"

      [[ -n "$badname" ]]  || die "couldn't find libtalloc reference in binary"
      [[ -n "$goodname" ]] || die "couldn't find libtalloc in nix store"

      echo "fixing libtalloc link in $lib"
      install_name_tool -change "$badname" "$goodname" "$lib"

      echo "fixing libtalloc link in $prg"
      install_name_tool -change "$badname" "$goodname" "$prg"
    '';
  });
}
