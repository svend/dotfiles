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
      netcat
      # netcat-gnu
      nix-prefetch-scripts
      nmap
      notmuch
      openssl
      openssh
      pandoc
      parallel
      pass # FTB 2019-03-25
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
      # tokei # count lines of code / FTB on Darwin: ld: framework not found Security
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
