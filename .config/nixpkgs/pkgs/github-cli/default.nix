{ stdenv, go, buildGoModule, fetchgit }:

buildGoModule rec {
  pname = "github-cli";
  version = "v0.8.0";
  rev = "${version}";

  src = fetchgit {
    inherit rev;
    url = "https://github.com/cli/cli.git";
    sha256 = "08fy3677yq52x40rab49ijhw4r25ls2807dbv9wpna6w07n7r8v7";
  };

  modSha256 = "0v33x9bnwjfg4425vralnsb4i22c0g1rcmaga9911v0i7d51k0fn";
}
