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
      chruby
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
      mercurial
      mr
      multi-x509
      netcat
      # netcat-gnu
      nix-prefetch-scripts
      nmap
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
      sshuttle
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
    ] ++ lib.optionals stdenv.isDarwin [
      terminal-notifier
    ] ++ lib.optionals stdenv.isLinux [
      gitAndTools.gitAnnex
      isync
      librecad
      notmuch # FTB on darwin: gpgme 2019-04-25
      qutebrowser
      signal-desktop
      smartmontools
      tokei # count lines of code / FTB on Darwin: ld: framework not found Security
      xcape
      xlibs.xmodmap
    ];
  };
}
