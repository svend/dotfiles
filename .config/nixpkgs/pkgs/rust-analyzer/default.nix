{ stdenv, fetchFromGitHub, rustPlatform, makeWrapper, CoreServices  }:

with rustPlatform;

buildRustPackage rec {
  name = "rust-analyzer-${version}";
  version = "2020-05-04";

  src = fetchFromGitHub {
    owner = "rust-analyzer";
    repo = "rust-analyzer";
    rev = "${version}";
    sha256 = "09q35wcs3ffkzbpx45z07xzmsiwkyjsjnn2d3697vv3iv4lg8i02";
  };

  # buildRustPackage requires a cargoSha256 attribute which is computed over all
  # crate sources of this package. Currently it is obtained by inserting a fake
  # checksum into the expression and building the package once. The correct
  # checksum can be then take from the failed build.
  cargoSha256 = "1kqmrxxb8abivg55h7k7280b8xi3vz71dgrjsjm46ma6i1xlyjxs";

  buildInputs = stdenv.lib.optionals stdenv.hostPlatform.isDarwin
    [ CoreServices ];

  # Test fail:
  #
  # running 1 test
  # test tests::test_loading_rust_analyzer ... FAILED
  #
  # failures:
  #
  # ---- tests::test_loading_rust_analyzer stdout ----
  # thread 'tests::test_loading_rust_analyzer' panicked at 'called `Result::unwrap()` on an `Err` value: "can\'t load standard library from sysroot\n\"/nix/store/f940n2ziqnv8iqr8pfbc98a91sgm16wn-rustc-1.39.0/lib/rustlib/src/rust/src\"\ntry running `rustup component add rust-src` or set `RUST_SRC_PATH`"', src/libcore/result.rs:1165:5
  doCheck = false;

  meta = with stdenv.lib; {
    description = " An experimental Rust compiler front-end for IDEs";
    homepage = https://github.com/rust-analyzer/rust-analyzer;
    license = with licenses; [ unlicense ];
    maintainers = [ ];
    platforms = platforms.all;
  };
}

# { pkgs, callPackage }:

# {
#   rust-analyzer = callPackage ./generic.nix rec {
#     rev = "2020-04-27";
#     version = "unstable-${rev}";
#     sha256 = "15y25ii1bs010jga87wi3jirqwq65jhjxfwxgriykzw10g7a97as";
#     cargoSha256 = "1ivxddigh8fasmqlah8k00bb0slil92w7mgfly1pz6bh6pac5lna";
#   };
# }
