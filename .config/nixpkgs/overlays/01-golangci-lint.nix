self: super:
{
  # https://github.com/NixOS/nixpkgs/pull/58336
  golangci-lint = with super; golangci-lint.overrideAttrs (old: rec {
    version = "1.16.0";

    src = fetchFromGitHub {
      owner = "golangci";
      repo = "golangci-lint";
      rev = "v${version}";
      sha256 = "1yzcfmrxyrxhq3vx13qm7czvhvdnaqay75v8ry1lgpg0bnh9pakx";
    };
  });
}
