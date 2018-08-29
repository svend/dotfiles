self: super:
{
  emacsHead = (super.emacs.override {
    srcRepo = true;
  }).overrideAttrs (old: rec {
    # name = "emacs-${version}${versionModifier}";
    # version = "26.0";
    # versionModifier = "-git-${builtins.substring 0 7 srcRev}";

    # # nix-prefetch-git --rev refs/heads/emacs-26 git://git.sv.gnu.org/emacs.git
    # srcRev = "e7952bdfc87aa333dfc564658bfbce6f1fbfc851";
    # srcSha = "1fsr2l8b9n6wm1ypx35k83blabl5sj2bjm2l7xm6b3vdrs02crn4";

    # src = super.fetchgit {
    #   url = "git://git.sv.gnu.org/emacs.git";
    #   rev = srcRev;
    #   sha256 = srcSha;
    # };
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
    py-isort
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
    scala-mode
    terraform-mode
    yaml-mode
  ]) ++
  (with epkgs.melpaPackages; [
    amx
    bash-completion
    blacken
    bpr
    flycheck-rust
    gnus-alias
    # kubernetes # FTB 2018-07-31: Searching for program: No such file or directory, git
    nix-mode
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
  [emacsPackagesNg-pdf-tools]);
}
