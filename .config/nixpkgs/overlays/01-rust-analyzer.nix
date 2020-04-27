self: super:
{
  # FIXME: Need to determine how to create overlay for rust-analyzer
  # rust-analyzer = with super; rust-analyzer.overrideAttrs (old: rec {
  #   rust-analyzer-unwrapped = callPackage ./generic.nix rec {
  #     rev = "2020-04-27";
  #     version = "unstable-${rev}";
  #     sha256 = "15y25ii1bs010jga87wi3jirqwq65jhjxfwxgriykzw10g7a97as";
  #     cargoSha256 = "1ivxddigh8fasmqlah8k00bb0slil92w7mgfly1pz6bh6pac5lna";
  #   };
  # });
}
