self: super:
{
  userEnv = with self; super.buildEnv {
    name = "userEnv";
    paths = [
      aspellWithDicts
      bashInteractive
      bash-completion
      # binutils # conflicts with rustEnv
      # cacert # nix default install includes nss-cacert-3.40.1
      coreutils
      dhall
      dhall-json
      dtach
      emacs
      etcdctl
      file
      findutils
      gawk
      gettext # for envsubst
      git-crypt
      gitAndTools.hub
      gitMinimal
      gnugrep
      gnuplot
      gnused
      gnutar
      graphviz
      gzip
      htop
      imagemagick
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
      # notmuch # FTB on darwin: gpg: can't connect to the agent: File name too long
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
      scriptisto
      sops
      stow
      time
      terraform
      terraform-lsp
      tokei # count lines of code
      tree
      unzip # required for Emacs nov.el package
      watch
      xsv
      xz
      zookeeper
      haskellPackages.ShellCheck

      # network tools
      curl
      bind
      fping
      ipcalc
      nmap
      openssh
      openssl
      rsync
      wrk2 # HTTP benchmarking tool
      wget

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
      gnupg # NixOS configuration includes gnupg
      passff-host # included with Firefox config on NixOS
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
