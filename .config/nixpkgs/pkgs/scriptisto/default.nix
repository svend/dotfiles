{ stdenv, fetchFromGitHub, rustPlatform, makeWrapper, Security  }:

with rustPlatform;

buildRustPackage rec {
  name = "scriptisto-${version}";
  version = "v0.6.2";

  src = fetchFromGitHub {
    owner = "igor-petruk";
    repo = "scriptisto";
    rev = "v0.6.2";
    sha256 = "04h5n3bc2664gd8xnwc4aczcqyldrvj8shnmam7pj2rkxn1kpn2s";
  };

  # buildRustPackage requires a cargoSha256 attribute which is computed over all
  # crate sources of this package. Currently it is obtained by inserting a fake
  # checksum into the expression and building the package once. The correct
  # checksum can be then take from the failed build.
  cargoSha256 = "1f89cidk1idm92j7cyvir8424bs4zmfcpv4m58xaxrbyq0qwv8v2";

  buildInputs = stdenv.lib.optional stdenv.isDarwin Security;

  meta = with stdenv.lib; {
    description = "A language-agnostic shebang interpreter that enables you to write scripts in compiled languages";
    homepage = https://github.com/igor-petruk/scriptisto;
    license = with licenses; [ unlicense ];
    maintainers = [ ];
    platforms = platforms.all;
  };
}
