{

# system.replaceRuntimeDependencies = with pkgs.lib;
#       [{original = pkgs.glibc; replacement = pkgs.stdenv.lib.overrideDerivation pkgs.glibc (oldAttr: { patches = oldAttr.patches ++
#         [(pkgs.fetchurl { url = "https://raw.githubusercontent.com/NixOS/nixpkgs/master/pkgs/development/libraries/glibc/cve-2015-7547.patch";
#                           sha256 = "0awpc4rp2x27rjpj83ps0rclmn73hsgfv2xxk18k82w4hdxqpp5r";})];
#        });}
#       ];

  packageOverrides = super: let self = super.pkgs; in with self; rec {
    # cairo = super.cairo.overrideDerivation (oldAttrs : {
    #   propagatedBuildInputs =
    #     with xorg; [ libXext fontconfig expat freetype pixman zlib libpng libXrender ]
    #     ++ stdenv.lib.optional stdenv.lib.optionals xcbSupport [ libxcb xcbutil ]
    #     ++ stdenv.lib.optional gobjectSupport glib
    #     ++ stdenv.lib.optional glSupport mesa_noglu
    #     ; # TODO: maybe liblzo but what would it be for here?
    # });

    emacsHead = pkgs.callPackage ~/src/nixpkgs/pkgs/applications/editors/emacs/head.nix {
      # use override to enable additional features
      libXaw = xorg.libXaw;
      Xaw3d = null;
      gconf = null;
      alsaLib = null;
      imagemagick = null;
      acl = null;
      gpm = null;
      inherit (darwin.apple_sdk.frameworks) AppKit CoreWLAN GSS Kerberos ImageIO;
      srcRepo = true;
    };

    emacs25PackagesNg-pdf-toolsHead = pkgs.stdenv.lib.overrideDerivation pkgs.emacs25PackagesNg.pdf-tools (attrs : {
      src = fetchFromGitHub {
        owner = "politza";
        repo = "pdf-tools";
        rev = "87d5b5794f5de02ac5a8c8aef2908db391a7a68c";
        sha256 = "1jm7w46jwzia62sv02rhgl98pjgb4rki0rnpcj1g6hwrwzm50pwn";
      };
    });

    userEnv = pkgs.buildEnv {
      name = "userEnv";
      paths = [
        aspell
        aspellDicts.en
        bashInteractive
        bash-completion
        bind
        binutils
        cacert
        coreutils
        curl
        chruby
        dtach
        emacsHead
        emacs25PackagesNg-pdf-toolsHead
        file
        findutils
        fping
        git-crypt
        gitAndTools.hub
        gitMinimal
        gnugrep
        gnupg
        gnused
        gnutar
        graphviz
        gzip
        htop
        imagemagick
        ipcalc
        jq
        keychain
        ledger
        less
        libvirt
        mercurial
        mr
        # netcat # libbsd FTB 2 2017-09-08
        netcat-gnu
        nim
        nix-prefetch-scripts
        notmuch
        openssh
        # pandoc # haskell jailbreak-install FTB 2017-09-08
        parallel
        pass
        postgresql
        pwgen
        redis
        restic
        ripgrep
        rsync
        # sshuttle # https://github.com/NixOS/nixpkgs/issues/27643
        stow
        time
        tree
        watch
        wget
        xz
        zookeeper
        # haskellPackages.ShellCheck # haskell jailbreak-install FTB 2017-09-08
      ];
    };

    goEnv = pkgs.buildEnv {
      name = "goEnv";
      paths = [
        glide
        go
        gocode
        godep
        godef
        goimports
        golint
      ];
    };

    pythonEnv = pkgs.buildEnv {
      name = "pythonEnv";
      paths = [
        python27
        python27Packages.pip
        python27Packages.flake8
        python27Packages.virtualenv
        python36
        python36Packages.pip
        python36Packages.pyyaml
      ];
    };

    rubyEnv = pkgs.buildEnv {
     name = "rubyEnv";
      paths = [
        bundler
        ruby
      ];
    };

    rustEnv = pkgs.buildEnv {
     name = "rustEnv";
       paths = [
         cargo
         openssl
         rustc
       ];
       buildInputs = [
         cargo
         openssl
         rustc
       ];
    };

    kubernetesEnv = pkgs.buildEnv {
        name = "kubernetesEnv";
        paths = [
          helm
          kubernetes
        ];
    };

    # Linux-specific packages
    linuxEnv = pkgs.buildEnv {
      name = "linuxEnv";
      paths = [
        chromium
        firefox-beta-bin
        gitAndTools.gitAnnex
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
