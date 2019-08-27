# Drop this after nixpkgs-unstable builds
self: super:
{
  nmap = with super; nmap.overrideAttrs (old: rec {
    patches = [ ./zenmap.patch ]
      ++ lib.optionals stdenv.cc.isClang [(
        # Fixes a compile error due an ambiguous reference to bind(2) in
        # nping/EchoServer.cc, which is otherwise resolved to std::bind.
        # https://github.com/nmap/nmap/pull/1363
        fetchpatch {
          url = "https://github.com/nmap/nmap/commit/5bbe66f1bd8cbd3718f5805139e2e8139e6849bb.diff";
          includes = [ "nping/EchoServer.cc" ];
          sha256 = "0xcph9mycy57yryjg253frxyz87c4135rrbndlqw1400c8jxq70c";
        }
      )];
  });
}
