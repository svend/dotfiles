{ stdenv, fetchFromGitHub, rustPlatform, makeWrapper, CoreServices, Security  }:

with rustPlatform;

buildRustPackage rec {
  name = "rust-analyzer-${version}";
  version = "dev";

  src = fetchFromGitHub {
    owner = "rust-analyzer";
    repo = "rust-analyzer";
    # rev = "${version}";
    rev = "8dd0e0086fc07422c9b1044b1db021cff6563214";
    sha256 = "1h24b2pi88ym3657xrqv4vdsl79czghkj5xfjsb10jgk8j729krz";
  };

  # buildRustPackage requires a cargoSha256 attribute which is computed over all
  # crate sources of this package. Currently it is obtained by inserting a fake
  # checksum into the expression and building the package once. The correct
  # checksum can be then take from the failed build.
  cargoSha256 = "09hrkrzl9bmjzdhp5w268w9vq92mzsl52f240wfnwyv445kp2mi5";

  buildInputs = stdenv.lib.optional stdenv.isDarwin [CoreServices Security];

  meta = with stdenv.lib; {
    description = " An experimental Rust compiler front-end for IDEs";
    homepage = https://github.com/rust-analyzer/rust-analyzer;
    license = with licenses; [ unlicense ];
    maintainers = [ ];
    platforms = platforms.all;
  };
}
