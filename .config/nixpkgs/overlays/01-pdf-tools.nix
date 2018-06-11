self: super:
{
  emacsPackagesNg-pdf-tools = with super; emacsPackagesNg.pdf-tools.overrideAttrs (old: rec {
   src = fetchFromGitHub {
     owner = "politza";
     repo = "pdf-tools";
     rev = "60d12ce15220d594e8eb95f4d072e2710cddefe0";
     sha256 = "1s8zphbd7k1ifdlisy894cg4mrkiq1rl2qk8x10njp1i596hz1fm";
    };
  });
}
