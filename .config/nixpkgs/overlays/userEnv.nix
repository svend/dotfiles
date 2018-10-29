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
      cacert
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
      # netcat # libbsd FTB 2017-09-08
      netcat-gnu
      # nix-prefetch-scripts # FTB 2018-06-28
      nmap
      notmuch
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
      rsync
      sshuttle
      stow
      time
      tokei
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
