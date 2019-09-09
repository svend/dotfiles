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
      sshuttle
      stow
      time
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
    ] ++ lib.optionals stdenv.isDarwin [
      terminal-notifier
    ] ++ lib.optionals stdenv.isLinux [
      gitAndTools.gitAnnex
      isync
      librecad
      notmuch # FTB on darwin: gpg: can't connect to the agent: File name too long
      qutebrowser
      signal-desktop
      smartmontools
      xcape
      xlibs.xmodmap
    ];
  };
}
