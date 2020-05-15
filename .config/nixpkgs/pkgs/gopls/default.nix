{ stdenv, go, buildGoModule, fetchgit, Security }:

buildGoModule rec {
  pname = "gopls";
  version = "v0.4.1";
  rev = "gopls/${version}";

  src = fetchgit {
    inherit rev;
    url = "https://go.googlesource.com/tools";
    sha256 = "18migk7arxm8ysfzidl7mdr069fxym9bfi6zisj7dliczw0qnkzv";
  };

  modRoot = "./gopls";

  vendorSha256 = "1jaav6c5vybgks5hc164is0i7h097c5l75s7w3wi5a3zyzkbiyny";

  buildInputs = stdenv.lib.optionals stdenv.isDarwin [ Security ];

  # Do not copy this without a good reason for enabling
  # In this case tools is heavily coupled with go itself and embeds paths.
  allowGoReference = true;
}
