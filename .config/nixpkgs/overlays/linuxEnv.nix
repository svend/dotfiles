self: super:
{
    # Linux-specific packages
    linuxEnv = with self; super.buildEnv {
      name = "linuxEnv";
      paths = [
        chromium
        firefox-beta-bin
        gitAndTools.gitAnnex
        librecad
        qutebrowser
        xcape
        xlibs.xmodmap
      ];
    };
}
