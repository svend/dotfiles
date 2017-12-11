{
  packageOverrides = pkgs: with pkgs; rec {
    my_aspell = aspellWithDicts(ps: with ps; [ en ]);

    emacsHead = (pkgs.emacs.override {
      srcRepo = true;
    }).overrideAttrs (oldAttrs: rec {
      name = "emacs-${version}${versionModifier}";
      version = "26.0";
      versionModifier = "-git-${builtins.substring 0 7 srcRev}";

      # nix-prefetch-git --rev refs/heads/emacs-26 git://git.sv.gnu.org/emacs.git
      srcRev = "87baf1242e9c0130148e5547804db6f1fbfb8c55";
      srcSha = "1wmhpikcri9gdkcc4zbpb9kb44c5qijppmrcv43swh1ln7hywl08";

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
        ace-link
        ace-window
        aggressive-indent
        bash-completion
        cider
        company
        company-jedi
        counsel
        exec-path-from-shell
        flycheck
        hydra
        ivy
        magit
        nov
        projectile
        racer
        robe
        smartparens
        super-save
        use-package
        visual-fill-column
        yasnippet

        # Modes
        clojure-mode
        dockerfile-mode
        gitconfig-mode
        gitignore-mode
        go-mode
        groovy-mode
        haskell-mode
        json-mode
        ledger-mode
        lua-mode
        markdown-mode
        nginx-mode
        nim-mode
        plantuml-mode
        rust-mode
        scala-mode
        terraform-mode
        yaml-mode
      ]) ++
      (with epkgs.melpaPackages; [
      amx
      flycheck-rust
      ibuffer-tramp
      ob-go
      # ob-scala
      ob-rust
      password-store
      # zoom-frm

      # Themes
      tao-theme
      tango-plus-theme

      # Modes
      toml-mode
    ]) ++
    (with epkgs.elpaPackages; [
    csv-mode
  ]) ++
  [emacs25PackagesNg.pdf-tools]);
    =======
      amx
      flycheck-rust
      ibuffer-tramp
      ob-go
      # ob-scala
      ob-rust
      password-store
      tao-theme
      tango-plus-theme

      nix-mode
      toml-mode
    ]) ++
    (with epkgs.elpaPackages; [
    csv-mode
  ]) ++
  [emacs25PackagesNg.pdf-tools]);
>>>>>>> b299661d57939399b335d5c74d3462c37168dc56

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
