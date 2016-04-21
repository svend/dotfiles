{ pkgs }: {

# system.replaceRuntimeDependencies = with pkgs.lib;
#       [{original = pkgs.glibc; replacement = pkgs.stdenv.lib.overrideDerivation pkgs.glibc (oldAttr: { patches = oldAttr.patches ++
#         [(pkgs.fetchurl { url = "https://raw.githubusercontent.com/NixOS/nixpkgs/master/pkgs/development/libraries/glibc/cve-2015-7547.patch";
#                           sha256 = "0awpc4rp2x27rjpj83ps0rclmn73hsgfv2xxk18k82w4hdxqpp5r";})];
#        });}
#       ];

packageOverrides = super: let self = super.pkgs; in with self; rec {
    # This is copied from nixpkgs/pkgs/top-level/all-packages.nix
    emacs-head = super.callPackage ~/src/nixpkgs.emacs-head/pkgs/applications/editors/emacs-head/default.nix {
      # use override to enable additional features
      libXaw = xorg.libXaw;
      Xaw3d = null;
      gconf = null;
      alsaLib = null;
      imagemagick = null;
      acl = null;
      gpm = null;
      inherit (darwin.apple_sdk.frameworks) AppKit CoreWLAN GSS Kerberos ImageIO;
    };

    userEnv = pkgs.buildEnv {
      name = "userEnv";
      paths = [
        # gitAndTools.hub
        # gitAndTools.gitAnnex

        # # go fails with dyld: Library not loaded: /usr/lib/libenergytrace.dylib
        # go

        aspell
        aspellDicts.en
        bashInteractive
        # binutils # strings (this also installs an `ld`, which doesn't work with rubygems)
        cacert
        coreutils
        curl
        chruby
        dtach
        emacs-head
        # emacs24PackagesNg.pdf-tools
        # emacsPackagesNg.melpaPackages.pdf-tools # unstable version (doesn't build epdfinfo binary)
        file
        findutils
        fping
        gitMinimal
        gnugrep
        gnupg21
        gnused
        gnutar
        graphviz
        gzip
        jq
        keychain
        less
        netcat
        nim
        nix-prefetch-scripts
        openssh
        pandoc # This build is expensive (haskell)
        parallel
        pass
        pwgen
        redis
        rsync
        stow
        time
        tree
        watch
        wget
        xz
        zookeeper
        haskellPackages.ShellCheck
      ];
    };

    pythonEnv = pkgs.buildEnv {
      name = "pythonEnv";
      paths = [
        python27Full
        python27Packages.pip
        python27Packages.flake8
        python27Packages.virtualenv
      ];
    };

    # Linux-specific packages
    linuxEnv = pkgs.buildEnv {
      name = "linuxEnv";
      paths = [
        bind # failing on darwin
        chromium
        firefox
        gitAndTools.gitAnnex
        ledger # boost is failing to build on darwin
        librecad
        xcape
        xlibs.xmodmap
      ];
    };

    # Mac-specific packages
    macEnv = pkgs.buildEnv {
      name = "macEnv";
      paths = [
        terminal-notifier
        pinentry_mac
      ];
    };
  };

  # Allow installation of broken packages to allow install on darwin platform
  allowBroken = true;
  allowUnfree = true;
}
