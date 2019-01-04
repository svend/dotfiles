self: super:
{
  emacsHead = (super.emacs.override {
    srcRepo = true;
  }).overrideAttrs (old: rec {
    name = "emacs-${version}${versionModifier}";
    version = "26.2-pre";
    versionModifier = "-git-${builtins.substring 0 7 srcRev}";

    # nix-prefetch-git --rev refs/heads/emacs-26 git://git.sv.gnu.org/emacs.git
    srcRev = "a058edae5b02a5265524140e42004a84f5c86907";
    srcSha = "1pxzy7b77gkixcqmq750vm39k0yyx5jfgwn5riiz1kvp84rxlwjf";

    src = super.fetchgit {
      url = "git://git.sv.gnu.org/emacs.git";
      rev = srcRev;
      sha256 = srcSha;
    };
  });

  emacs = with self; let customEmacsPackages =
    super.emacsPackagesNg.overrideScope (self: super: {
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
    ivy # https://github.com/abo-abo/swiper/commit/b022886c0392bd7a04d8296a2c6c68d2d858d841
    # kubernetes # FTB 2018-07-31: Searching for program: No such file or directory, git
    nix-mode
    ob-go
    # ob-scala
    ob-rust
    password-store
    ripgrep # https://github.com/nlamirault/ripgrep.el/compare/0.4.0...master
    spacemacs-theme
    tao-theme
    tango-plus-theme
    visual-fill-column # https://github.com/joostkremers/visual-fill-column/compare/1.11...master

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
