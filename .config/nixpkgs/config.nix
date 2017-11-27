{ pkgs }: let
    # Copied from nixpkgs/pkgs/top-level/all-packages.nix (emacs25)
    emacsHead = pkgs.callPackage ~/src/nixpkgs/pkgs/applications/editors/emacs/head.nix {
      # use override to enable additional features
      libXaw = pkgs.xorg.libXaw;
      Xaw3d = null;
      gconf = null;
      alsaLib = null;
      imagemagick = null;
      acl = null;
      gpm = null;
      inherit (pkgs.darwin.apple_sdk.frameworks) AppKit CoreWLAN GSS Kerberos ImageIO;
      # Autoconf, etc
      srcRepo = true;
    };
in {
  packageOverrides = pkgs: with pkgs; rec {
    # cairo = super.cairo.overrideDerivation (oldAttrs : {
    #   propagatedBuildInputs =
    #     with xorg; [ libXext fontconfig expat freetype pixman zlib libpng libXrender ]
    #     ++ stdenv.lib.optional stdenv.lib.optionals xcbSupport [ libxcb xcbutil ]
    #     ++ stdenv.lib.optional gobjectSupport glib
    #     ++ stdenv.lib.optional glSupport mesa_noglu
    #     ; # TODO: maybe liblzo but what would it be for here?
    # });

    # Copied from nixpkgs/pkgs/top-level/all-packages.nix (emacs25)
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
      # Autoconf, etc
      srcRepo = true;
    };

    emacs25PackagesNg-pdf-toolsHead = let emacs = emacsHead; in pkgs.stdenv.lib.overrideDerivation pkgs.emacs25PackagesNg.pdf-tools (attrs : {
      src = fetchFromGitHub {
        owner = "politza";
        repo = "pdf-tools";
        rev = "094b2931de775c734ad353c5d06cf5fc6a55f11d";
        sha256 = "0g92rd68m1l377hw5rr1y14z7fcs1blmyc6vi5a9gybr19bcxb7w";
      };
    });

    emacsEnv = let customEmacsPackages =
      emacsPackagesNg.overrideScope (super: self: {
      # use a custom version of emacs
      emacs = emacsHead;
    });
  in customEmacsPackages.emacsWithPackages (epkgs:
      (with epkgs.melpaStablePackages; [
        magit
      ]) ++
      (with epkgs.melpaPackages; []) ++
      (with epkgs.elpaPackages; []) ++
      [emacs25PackagesNg-pdf-toolsHead]);

    my_aspell = aspellWithDicts(ps: with ps; [ en ]);

    userEnv = pkgs.buildEnv {
      name = "userEnv";
      paths = [
        my_aspell
        bashInteractive
        bash-completion
        bind
        binutils
        cacert
        coreutils
        curl
        chruby
        direnv
        dtach
        # emacs25PackagesNg-pdf-toolsHead # Collision with emacsEnv
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
        # libvirt # 2017-10-27
        mercurial
        mr
        # netcat # libbsd FTB 2017-09-08
        netcat-gnu
        nim
        nix-prefetch-scripts
        notmuch
        openssh
        # pandoc # FTB 2017-09-22
        parallel
        pass
        plantuml
        postgresql
        python36Packages.piep
        pwgen
        redis
        restic
        ripgrep
        rsync
        # sshuttle # https://github.com/NixOS/nixpkgs/issues/27643
        stow
        time
        tree
        unzip # Required for Emacs nov.el package
        watch
        wrk # HTTP benchmarking tool
        wget
        xz
        zookeeper
        haskellPackages.ShellCheck
      ];
    };

    goEnv = pkgs.buildEnv {
      name = "goEnv";
      paths = [
        dep
        glide
        go
        gocode
        godep
        godef
        goimports
        golint
      ];
    };

    # See https://github.com/NixOS/nixpkgs/issues/10597#issuecomment-313908853
    pythonEnv = pkgs.buildEnv {
      name = "pythonEnv";
      paths = [
        (with python27Packages; python.buildEnv.override {
          extraLibs = [
            pip
            openssl
            virtualenv
          ];
        })
          (with python36Packages; python.buildEnv.override {
          extraLibs = [
            flake8
            pip
            pyyaml
            requests
            # xonsh
          ];
        })
        ];
    };

    clojureEnv = pkgs.buildEnv {
      name = "clojureEnv";
      paths = [
        clojure
        leiningen
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
