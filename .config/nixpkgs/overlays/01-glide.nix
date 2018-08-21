 self: super:
{
  glide = with super; glide.overrideAttrs (old: rec {
    name = "glide-${version}";
    version = "0.13.1";

    buildFlagsArray = ''
    -ldflags=
       -X main.version=${version}
    '';

    src = fetchFromGitHub {
      rev = "v${version}";
      owner = "Masterminds";
      repo = "glide";
      sha256 = "1gbik31mxb9m9j2lm1n4da049914r1404fi0j5g6b08i69dd092v";
    };
  });
}
