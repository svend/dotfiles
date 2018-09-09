{ stdenv, fetchFromGitHub, rustPlatform, makeWrapper }:

with rustPlatform;

buildRustPackage rec {
  name = "cargo-script-${version}";
  version = "2018-09-09";

  src = fetchFromGitHub {
    owner = "svend";
    repo = "multi-x509";
    # rev = "${version}";
    rev = "6798d5f7b7c5679743362c86ad4676b7bd906ba4";
    sha256 = "18fljjr49lpi1lyxwfx0bsp9fhz5ii63w8hsskjqahgvdqay3bdf";
  };

  cargoSha256 = "1cgqk1dj8ln1x0ll63h83alrazhic20bqjzrn0kmphf136d9z8fm";
  doCheck = false;
  meta = with stdenv.lib; {
    description = "Run a command on each x509 certificate";
    homepage = https://github.com/svend/multi-x509;
    license = with licenses; [ unlicense ];
    maintainers = [ ];
    platforms = platforms.all;
  };
}
