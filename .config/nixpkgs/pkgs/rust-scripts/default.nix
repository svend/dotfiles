{ stdenv, fetchFromGitHub, rustPlatform, makeWrapper, Security  }:

with rustPlatform;

buildRustPackage rec {
  name = "rust-scripts-${version}";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "svend";
    repo = "rust-scripts";
    # rev = "${version}";
    rev = "dd415524aad6dd92d72dd27823d6f8ac2d6e4850";
    sha256 = "08y0yvv3bkywkc0vbh787lyfhzd335h55wyxfjfch3mxhp4mkk5r";
  };

  # buildRustPackage requires a cargoSha256 attribute which is computed over all
  # crate sources of this package. Currently it is obtained by inserting a fake
  # checksum into the expression and building the package once. The correct
  # checksum can be then take from the failed build.
  cargoSha256 = "0xml0a0sk06l1h3kxb27dwdq27b2y8v7kdqqd2d9h7pchqq6m5cc";

  buildInputs = stdenv.lib.optional stdenv.isDarwin Security;

  meta = with stdenv.lib; {
    description = "Various rust scripts";
    homepage = https://github.com/svend/rust-scripts;
    license = with licenses; [ unlicense ];
    maintainers = [ ];
    platforms = platforms.all;
  };
}
