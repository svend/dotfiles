self: super:
with super.pkgs;
{
    emacsHead = (pkgs.emacs.override {
      srcRepo = true;
    }).overrideAttrs (oldAttrs: rec {
      name = "emacs-${version}${versionModifier}";
      version = "26.0";
      versionModifier = "-git-${builtins.substring 0 7 srcRev}";

      # nix-prefetch-git --rev refs/heads/emacs-26 git://git.sv.gnu.org/emacs.git
      srcRev = "1fc98ed073a2d26ad941748ecb13aa6f47dd7b01";
      srcSha = "1vvr9pc4hdrj087wy1h9hamw348v8m6q7i4jkfjp0dfrsyzivi2x";

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
        cider
        company
        company-jedi
        counsel
        edit-indirect
        exec-path-from-shell
        expand-region
        flycheck
        hydra
        ivy
        magit
        notmuch
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
        haskell-mode
        ibuffer-tramp
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
      bash-completion
      bpr
      flycheck-rust
      gnus-alias
      ob-go
      # ob-scala
      ob-rust
      password-store
      tao-theme
      tango-plus-theme

      # Modes
      groovy-mode
      nix-mode
      toml-mode
    ]) ++
    (with epkgs.elpaPackages; [
    csv-mode
  ]) ++
  [emacs25PackagesNg.pdf-tools]);

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
        emacs
        etcdctl
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
}
