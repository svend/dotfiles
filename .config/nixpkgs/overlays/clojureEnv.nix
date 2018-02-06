self: super:
with super.pkgs;
{
    clojureEnv = pkgs.buildEnv {
      name = "clojureEnv";
      paths = [
        clojure
        leiningen
      ];
    };
}
