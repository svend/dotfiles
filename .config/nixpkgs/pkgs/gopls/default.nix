{ stdenv, go, buildGoModule, fetchgit, Security }:

buildGoModule rec {
  pname = "gopls";
  version = "v0.3.3";
  rev = "gopls/v0.3.4";

  src = fetchgit {
    inherit rev;
    url = "https://go.googlesource.com/tools";
    sha256 = "0rqcrz5fkld92wv0n9993qq4mspqhqf9d8d6qciiby0p227q5yhk";
  };

  modRoot = "./gopls";

  modSha256 = "1ni0gfrgnkjddpdmknkgyac6wf0r3aq9na27bv7zf3k20ii22213";

  buildInputs = stdenv.lib.optionals stdenv.isDarwin [ Security ];

  # Do not copy this without a good reason for enabling
  # In this case tools is heavily coupled with go itself and embeds paths.
  allowGoReference = true;
}
