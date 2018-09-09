{ stdenv, fetchFromGitHub, rustPlatform, makeWrapper }:

with rustPlatform;

buildRustPackage rec {
  name = "multi-x509-${version}";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "svend";
    repo = "multi-x509";
    # rev = "${version}";
    rev = "6798d5f7b7c5679743362c86ad4676b7bd906ba4";
    sha256 = "1h70vyxx843bqyx447jkd08prpq1xdjxn2yy0lnfj8dkcwm6x4jf";
  };

  cargoSha256 = "1ii9sqfm6ipw0nxpc0pcncrg6xylglp6srdznjwmqv233k60ra5h";
  doCheck = false;
  meta = with stdenv.lib; {
    description = "Run a command on each x509 certificate";
    homepage = https://github.com/svend/multi-x509;
    license = with licenses; [ unlicense ];
    maintainers = [ ];
    platforms = platforms.all;
  };
}
