self: super:
with super.pkgs;
{
    # Linux-specific packages
    linuxEnv = pkgs.buildEnv {
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
