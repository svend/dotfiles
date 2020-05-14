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

  modSha256 = "1p0g28i707xyxz1g6hb56qlc4km9ik7vjky0v80hw7n73vzs5mr9";

  buildInputs = stdenv.lib.optionals stdenv.isDarwin [ Security ];

  # Do not copy this without a good reason for enabling
  # In this case tools is heavily coupled with go itself and embeds paths.
  allowGoReference = true;
}
