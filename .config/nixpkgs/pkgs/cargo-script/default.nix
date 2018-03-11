{ stdenv, fetchFromGitHub, rustPlatform, makeWrapper }:

with rustPlatform;

buildRustPackage rec {
  name = "cargo-script-${version}";
  version = "0.2.8";

  src = fetchFromGitHub {
    owner = "DanielKeep";
    repo = "cargo-script";
    # rev = "${version}";
    rev = "dcf518910010cc688a5ca2a7ebe22c6e714640ee";
    sha256 = "18fljjr49lpi1lyxwfx0bsp9fhz5ii63w8hsskjqahgvdqay3bdf";
  };

  cargoSha256 = "1cgqk1dj8ln1x0ll63h83alrazhic20bqjzrn0kmphf136d9z8fm";
  doCheck = false;
  meta = with stdenv.lib; {
    description = "Cargo script subcommand";
    homepage = https://github.com/DanielKeep/cargo-script;
    license = with licenses; [ unlicense /* or */ mit ];
    maintainers = [ maintainers.tailhook ];
    platforms = platforms.all;
  };
}
