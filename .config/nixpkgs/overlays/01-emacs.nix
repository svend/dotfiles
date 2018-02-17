self: super:
{
  emacsHead = (super.emacs.override {
    srcRepo = true;
  }).overrideAttrs (old: rec {
    name = "emacs-${version}${versionModifier}";
    version = "26.0";
    versionModifier = "-git-${builtins.substring 0 7 srcRev}";

    # nix-prefetch-git --rev refs/heads/emacs-26 git://git.sv.gnu.org/emacs.git
    srcRev = "333d6f4d99a80f30ae6cd3880b9d9ec38a85691b";
    srcSha = "08arkz6n9mnn5drf3mnf7xvhzs7a0n9v01dlc1p680zmxci7nwaf";

    src = super.fetchgit {
      url = "git://git.sv.gnu.org/emacs.git";
      rev = srcRev;
      sha256 = srcSha;
    };

    patches = []; #lib.optional stdenv.isDarwin ./at-fdcwd.patch;
  });

  emacs = with self; let customEmacsPackages =
    super.emacsPackagesNg.overrideScope (super: self: {
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
      go-eldoc
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
      nix-mode # TODO: Switch to melpaPackages on next nixpkgs-unstable update
      plantuml-mode
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
    ripgrep # https://github.com/nlamirault/ripgrep.el/compare/0.4.0...master
    tao-theme
    tango-plus-theme

    # Modes
    groovy-mode
    rust-mode # https://github.com/rust-lang/rust-mode/compare/0.3.0...master
    toml-mode
  ]) ++
  (with epkgs.elpaPackages; [
  csv-mode
]) ++
[emacs25PackagesNg.pdf-tools]);
}
