self: super:
{
  glide = with super; glide.overrideAttrs (old: rec {
    name = "glide-${version}";
    version = "0.13.3";

    buildFlagsArray = ''
    -ldflags=
       -X main.version=${version}
    '';

    src = fetchFromGitHub {
      rev = "v${version}";
      owner = "Masterminds";
      repo = "glide";
      sha256 = "1wskg1cxqy9sp0738qiiagdw09dbs3swxsk4z6w5hsfiq2h44a54";
    };
  });
}
