{ stdenv, fetchFromGitHub, rustPlatform, makeWrapper, CoreServices, Security  }:

with rustPlatform;

buildRustPackage rec {
  name = "rust-analyzer-${version}";
  version = "dev";

  src = fetchFromGitHub {
    owner = "rust-analyzer";
    repo = "rust-analyzer";
    # rev = "${version}";
    # Requires rust 1.40 or newer
    # rev = "2d003b6378edc84be42abe98c377ec0ec2bf4ae9";
    rev = "9f616ed65a3cd3088a006ab9f116c2b9a2235cb6";
    sha256 = "00q2j1ksank7ya295nd7njwh31fyx2d1xqm7p3y9df7j1zjqlwh1";
  };

  # buildRustPackage requires a cargoSha256 attribute which is computed over all
  # crate sources of this package. Currently it is obtained by inserting a fake
  # checksum into the expression and building the package once. The correct
  # checksum can be then take from the failed build.
  cargoSha256 = "18m980s2li8ixynicigz7v4h2dk7b593qv63p2cv52pw096z9gvv";

  buildInputs = stdenv.lib.optional stdenv.isDarwin [CoreServices Security];

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
