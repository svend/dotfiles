self: super:
{
  xcape = with super; xcape.overrideAttrs (old: rec {
    baseName = "xcape";
    src = fetchFromGitHub {
      owner = "alols";
      repo = baseName;
      rev = "6ded5b453b50642197044a170402664cbf6d2c96";
      sha256 = "193dz9n3y5jchxnpzm2yyyhx30ncn2s8rfr3hhr18aldi0cv548k";
    };
  });
}
