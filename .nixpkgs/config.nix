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

    emacs = super.callPackage ~/src/nixpkgs.emacs-head/pkgs/applications/editors/emacs-head/default.nix {
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

    emacs25PackagesNg-pdf-toolsHead = pkgs.stdenv.lib.overrideDerivation pkgs.emacs25PackagesNg.pdf-tools (oldAttrs : {
      src = fetchFromGitHub {
        owner = "politza";
        repo = "pdf-tools";
        rev = "87690b7b568ae6145dfa4ffc9fc085b80ed039fa";
        sha256 = "14h8vybd0lns92mxv045mfcllhq8fj509bvf7i9vr190mxgnxv3s";
      };
    });

    userEnv = pkgs.buildEnv {
      name = "userEnv";
      paths = [
        aspell
        aspellDicts.en
        bashInteractive
        bind
        # binutils # strings (this also installs an `ld`, which doesn't work with rubygems)
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
        libvirt
        mr
        netcat
        nim
        nix-prefetch-scripts
        openssh
        pandoc # This build is expensive (haskell)
        parallel
        pass
        postgresql
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
        python27Packages.virtualenv
        python35
        # flycheck requires flake8 > 3.x, nixpkgs contains 2.5.4
        # install flake8 via pip
        python35Packages.flake8
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
