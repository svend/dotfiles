{ stdenv, fetchFromGitHub, rustPlatform, makeWrapper, Security  }:

with rustPlatform;

buildRustPackage rec {
  name = "rust-scripts-${version}";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "svend";
    repo = "rust-scripts";
    # rev = "${version}";
    rev = "d5bdd9c6f8745219dfd97c86ade8a3ed1c1c057a";
    sha256 = "1bqcc6895v340xkj86nw5cpz8fqvn3s4ld2bxq83jqsvknrzd0ib";
  };

  # buildRustPackage requires a cargoSha256 attribute which is computed over all
  # crate sources of this package. Currently it is obtained by inserting a fake
  # checksum into the expression and building the package once. The correct
  # checksum can be then take from the failed build.
  cargoSha256 = "1ig5xx2gg8w3gjiknzd2asblqfw8mpa3ssb23x1nzqjsgz0iqff5";

  buildInputs = stdenv.lib.optional stdenv.isDarwin Security;

  meta = with stdenv.lib; {
    description = "Various rust scripts";
    homepage = https://github.com/svend/rust-scripts;
    license = with licenses; [ unlicense ];
    maintainers = [ ];
    platforms = platforms.all;
  };
}
