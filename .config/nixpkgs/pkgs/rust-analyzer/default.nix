{ stdenv, fetchFromGitHub, rustPlatform, makeWrapper, CoreServices, Security  }:

with rustPlatform;

buildRustPackage rec {
  name = "rust-analyzer-${version}";
  version = "2020-01-27";

  src = fetchFromGitHub {
    owner = "rust-analyzer";
    repo = "rust-analyzer";
    rev = "${version}";
    sha256 = "090a0bw9jmy37zwnxbqy10syiq9fd2jrfcjsghmzs5vihc67zzkn";
  };

  # buildRustPackage requires a cargoSha256 attribute which is computed over all
  # crate sources of this package. Currently it is obtained by inserting a fake
  # checksum into the expression and building the package once. The correct
  # checksum can be then take from the failed build.
  cargoSha256 = "0s2jwrplyvk5gzhmmjbncsq9mhlna74fkxi1vblk4gqi51psrlbp";

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
