self: super:
{
  emacsHead = (super.emacs.override {
    srcRepo = true;
  }).overrideAttrs (old: rec {
    name = "emacs-${version}${versionModifier}";
    version = "26.2-pre";
    versionModifier = "-git-${builtins.substring 0 7 srcRev}";

    # nix-prefetch-git --rev refs/heads/emacs-26 git://git.sv.gnu.org/emacs.git
    srcRev = "emacs-26.2";
    srcSha = "0wln9zadc2n5vxi5z20mx2i1544ni8l4z81kh9dda10jz8ddwsqj";

    src = super.fetchgit {
      url = "git://git.sv.gnu.org/emacs.git";
      rev = srcRev;
      sha256 = srcSha;
    };
  });

  # https://github.com/NixOS/nixpkgs/blob/7c93bbec22508f40b05660d56b28eb5002872bd7/pkgs/build-support/emacs/wrapper.nix
  emacs = with self; let customEmacsPackages =
    emacsPackagesNg.overrideScope' (self: super: {
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
    diminish
    edit-indirect
    exec-path-from-shell
    expand-region
    flycheck
    go-eldoc
    hydra
    ivy
    lv # Remove when hydra 0.15 hits nixpkgs-unstable: https://github.com/abo-abo/hydra/pull/324
    magit
    notmuch
    nov
    projectile
    py-isort
    robe
    smartparens
    super-save
    use-package
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
    scala-mode
    terraform-mode
    yaml-mode
  ]) ++
  (with epkgs.melpaPackages; [
    amx
    bash-completion
    blacken
    bpr
    company-go
    flycheck-rust
    flycheck-golangci-lint
    gnus-alias
    nix-mode
    ob-go
    # ob-scala
    ob-rust
    password-store
    racer # https://github.com/racer-rust/emacs-racer/compare/1.2...master
    ripgrep # https://github.com/nlamirault/ripgrep.el/compare/0.4.0...master
    ruby-tools
    spacemacs-theme
    tao-theme
    tango-plus-theme
    visual-fill-column # https://github.com/joostkremers/visual-fill-column/compare/1.11...master

    # Modes
    groovy-mode
    jsonnet-mode
    rust-mode # https://github.com/rust-lang/rust-mode/compare/0.4.0...master
    toml-mode
  ]) ++
  (with epkgs.elpaPackages; [
    csv-mode
  ]) ++
  ([emacsPackagesNg.pdf-tools])
  );
}
