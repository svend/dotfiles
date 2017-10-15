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

    emacs25PackagesNg-pdf-toolsHead = pkgs.stdenv.lib.overrideDerivation pkgs.emacs25PackagesNg.pdf-tools (attrs : {
      src = fetchFromGitHub {
        owner = "politza";
        repo = "pdf-tools";
        rev = "52acd65c0db97a83e3f86ca97f9a3bf27135e8f3";
        sha256 = "19d5nmy7kdlysxzig2akbxvg9h1vnjagp4xh1qpyw8iqgm3kpxxn";
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

    pythonEnv = pkgs.buildEnv {
      name = "pythonEnv";
      paths = [
        python36
        python36Packages.pip
        python36Packages.pyyaml
        python27
        python27Packages.pip
        python27Packages.flake8
        python27Packages.virtualenv
      ];
    };

    # python2Env and python3Env don't install in parallel
    python2Env = pkgs.buildEnv {
      name = "python2Env";
      paths = [
        python27
        python27Packages.pip
        python27Packages.flake8
        python27Packages.virtualenv
      ];
    };

    python3Env = pkgs.buildEnv {
      name = "python3Env";
      paths = [
        (with python36Packages; python.buildEnv.override {
          extraLibs = [
            setuptools
            jedi
            flake8
            numpy
            isort
            yapf
            pip
            pytest
            pyyaml
          ];
        })
        ];
    };

    python3WithPkgs = python36Packages.python.buildEnv.override {
      extraLibs = with python36Packages; [
        python36Packages.pip
        python36Packages.pyyaml
        python36Packages.setuptools
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
