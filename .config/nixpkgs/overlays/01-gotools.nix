self: super:
{
  gotools = with super; gotools.overrideAttrs (old: rec {
    # Do not install things like `link`
    preConfigure = ''
      # # Make the builtin tools available here
      # mkdir -p $bin/bin
      # eval $(go env | grep GOTOOLDIR)
      # find $GOTOOLDIR -type f | while read x; do
      #   ln -sv "$x" "$bin/bin"
      # done
      export GOTOOLDIR=$bin/bin
    '';
  });
}