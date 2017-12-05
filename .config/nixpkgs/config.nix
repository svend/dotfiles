{
  packageOverrides = pkgs: with pkgs; rec {
    my_aspell = aspellWithDicts(ps: with ps; [ en ]);

    # # Copied from nixpkgs/pkgs/top-level/all-packages.nix (emacs25)
    # emacsHead = pkgs.callPackage ~/src/nixpkgs/pkgs/applications/editors/emacs/head.nix {
    #   # use override to enable additional features
    #   libXaw = xorg.libXaw;
    #   Xaw3d = null;
    #   gconf = null;
    #   alsaLib = null;
    #   imagemagick = null;
    #   acl = null;
    #   gpm = null;
    #   inherit (darwin.apple_sdk.frameworks) AppKit CoreWLAN GSS Kerberos ImageIO;
    #   # Autoconf, etc
    #   srcRepo = true;
    # };

    # emacs25PackagesNg-pdf-toolsHead = pkgs.emacs25PackagesNg.pdf-tools.overrideAttrs (oldAttrs: rec {
    #   src = fetchFromGitHub {
    #     owner = "politza";
    #     repo = "pdf-tools";
    #     rev = "094b2931de775c734ad353c5d06cf5fc6a55f11d";
    #     sha256 = "0g92rd68m1l377hw5rr1y14z7fcs1blmyc6vi5a9gybr19bcxb7w";
    #   };
    # });

    emacsHead = (pkgs.emacs.override {
      srcRepo = true;
    }).overrideAttrs (oldAttrs: rec {
      name = "emacs-${version}${versionModifier}";
      version = "26.0";
      versionModifier = "-git-${builtins.substring 0 7 srcRev}";

      # nix-prefetch-git --rev refs/heads/emacs-26 git://git.sv.gnu.org/emacs.git
      srcRev = "8227087194e0817b984ce3b15099f5eae4dc011c";
      srcSha = "0qj0rghgb62ngkvcbkm2dbha9l3z7gy7jjfghsj94la76hj3f5qd";

      src = fetchgit {
        url = "git://git.sv.gnu.org/emacs.git";
        rev = srcRev;
        sha256 = srcSha;
      };

      patches = []; #lib.optional stdenv.isDarwin ./at-fdcwd.patch;
    });

    my_emacs = let customEmacsPackages =
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
      [emacs25PackagesNg.pdf-tools]);

    xcape = pkgs.xcape.overrideAttrs (oldAttrs: rec {
      baseName = "xcape";
      src = fetchFromGitHub {
        owner = "alols";
        repo = baseName;
        rev = "6ded5b453b50642197044a170402664cbf6d2c96";
        sha256 = "193dz9n3y5jchxnpzm2yyyhx30ncn2s8rfr3hhr18aldi0cv548k";
      };
    });

    xonsh = pkgs.xonsh.overrideAttrs (oldAttrs: rec {
      # Check fails on macOS
      doInstallCheck = !stdenv.isDarwin;
      propagatedBuildInputs = with python3Packages; [
        ply
        prompt_toolkit
        pyyaml
        requests
      ];
    });

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
        my_emacs
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
        openssl
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

    # See https://github.com/NixOS/nixpkgs/issues/10597#issuecomment-313908853
    pythonEnv = pkgs.buildEnv {
      name = "pythonEnv";
      paths = [
        (with python27Packages; python.buildEnv.override {
          extraLibs = [
            pip
            virtualenv
          ];
        })
          (with python3Packages; python.buildEnv.override {
          extraLibs = [
            flake8
            pip
            pyyaml
            requests
          ];
        })
          xonsh
          pipenv
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
        rustc
      ];
      buildInputs = [
        cargo
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
