self: super:
{
  # TODO: overriding vendorSha256 has no effect
  # gopls = with super; gopls.overrideAttrs (old: rec {
  #   version = "0.4.2";

  #   src = fetchgit {
  #     rev = "gopls/v${version}";
  #     url = "https://go.googlesource.com/tools";
  #     sha256 = "1i9q9842d7ndzqcpg934brhm27lrfjjdlf91ly8ipwpsms574jlx";
  #   };

  #   # vendorSha256 = "0000000000000000000000000000000000000000000000000000";
  # });
}
