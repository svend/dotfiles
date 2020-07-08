{ stdenv, go, buildGoModule, fetchgit }:

buildGoModule rec {
  pname = "gopls";
  version = "0.4.2";

  src = fetchgit {
    rev = "gopls/v${version}";
    url = "https://go.googlesource.com/tools";
    sha256 = "1i9q9842d7ndzqcpg934brhm27lrfjjdlf91ly8ipwpsms574jlx";
  };

  modRoot = "gopls";
  vendorSha256 = "0c2h03kqyh2jjp9957kmpybgw17apc4np3za9hzg8j0d8kkli5mm";

  meta = with stdenv.lib; {
    description = "Official language server for the Go language";
    homepage = "https://github.com/golang/tools/tree/master/gopls";
    license = licenses.bsd3;
    maintainers = with maintainers; [ mic92 ];
  };
}
