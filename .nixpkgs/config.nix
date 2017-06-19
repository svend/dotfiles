{ pkgs }: {

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

    emacsHead = super.callPackage ~/src/nixpkgs.emacs-head/pkgs/applications/editors/emacs/head.nix {
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

    emacs25PackagesNg-pdf-toolsHead = pkgs.stdenv.lib.overrideDerivation pkgs.emacs25PackagesNg.pdf-tools (oldAttrs : {
      src = fetchFromGitHub {
        owner = "politza";
        repo = "pdf-tools";
        rev = "3a32d2420cc40ed864215f75aae4f6d868dc1cd2";
        sha256 = "15j8ll2rna5f0a4zq2bflbn888c6yp852i405qlcxcjvs3jalxcy";
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
        binutils # strings (this also installs an `ld`, which doesn't work with rubygems)
        cacert
        coreutils
        curl
        chruby
        dtach
        emacs
        emacs25PackagesNg-pdf-toolsHead
        file
        findutils
        fping
        git-crypt
        gitAndTools.hub
        gitMinimal
        gnugrep
        gnupg21
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
        # libvirt # 2017-04-03 builder for ‘/nix/store/s844y53v7c4p3086yzfwjlmf4h01ms28-attr-2.4.47.drv’ failed with exit code 2
        mercurial
        mr
        # netcat # builder for ‘/nix/store/ph3kjq0wf2jj8k8r6zz9xcc6fq1b3cg7-libbsd-0.8.2.drv’ failed with exit code 2
        netcat-gnu
        nim
        nix-prefetch-scripts
        openssh
        pandoc
        parallel
        pass
        postgresql
        pwgen
        redis
        ripgrep
        rsync
        sshuttle
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

    goEnv = pkgs.buildEnv {
      name = "goEnv";
      paths = [
        glide
        go
        gocode
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
        firefox
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
