self: super:
{
    go = with super; go.overrideAttrs (old: rec {
      postBuild = ''
      (cd src && true && ./make.bash)
      '';
    });
}
