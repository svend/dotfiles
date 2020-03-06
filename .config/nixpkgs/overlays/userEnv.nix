self: super:
{
  userEnv = with self; super.buildEnv {
    name = "userEnv";
    paths = [
      aspellWithDicts
      bashInteractive
      bash-completion
      bind
      # binutils # conflicts with rustEnv
      # cacert # nix default install includes nss-cacert-3.40.1
      coreutils
      curl
      dhall
      dhall-json
      dtach
      emacs
      etcdctl
      file
      findutils
      fping
      gettext # for envsubst
      git-crypt
      gitAndTools.hub
      gitMinimal
      gnugrep
      gnuplot
      gnupg
      gnused
      gnutar
      graphviz
      gzip
      htop
      imagemagick
      ipcalc
      jq
      jsonnet
      keychain
      gnuplot
      ledger
      less
      mercurial
      mr
      multi-x509
      # netcat # use nmap/ncat
      # netcat-gnu # use nmap/ncat
      nix-prefetch-scripts
      nmap
      # notmuch # FTB on darwin: gpg: can't connect to the agent: File name too long
      openssl
      openssh
      pandoc
      parallel
      pass
      plantuml
      postgresql
      pwgen
      redis
      restic
      ripgrep
      rust-scripts
      rsync
      scriptisto
      # sshuttle # broken by https://github.com/NixOS/nixpkgs/pull/80746
      sops
      stow
      time
      terraform
      terraform-lsp
      tokei # count lines of code
      tree
      unzip # required for Emacs nov.el package
      watch
      wrk2 # HTTP benchmarking tool
      wget
      xsv
      xz
      zookeeper
      haskellPackages.ShellCheck

      # fonts
      dejavu_fonts
      fira
      fira-code
      iosevka
      # input-fonts # non-free
      jetbrains-mono
      go-font
      oxygenfonts
      source-code-pro
    ] ++ lib.optionals stdenv.isDarwin [
      pinentry_mac
      terminal-notifier
    ] ++ lib.optionals stdenv.isLinux [
      gitAndTools.gitAnnex # slow to build, linux has pre-built binaries
      isync # mbsync
      librecad
      notmuch # FTB on darwin: gpg: can't connect to the agent: File name too long
      smartmontools
      xcape
      xlibs.xmodmap
    ];
  };
}
