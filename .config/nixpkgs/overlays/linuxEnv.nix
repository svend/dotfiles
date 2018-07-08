self: super:
{
  # Linux-specific packages
  linuxEnv = with self; super.buildEnv {
    name = "linuxEnv";
    paths = [
      gitAndTools.gitAnnex
      librecad
      isync
      qutebrowser
      signal-desktop
      smartmontools
      xcape
      xlibs.xmodmap
    ];
  };
}
