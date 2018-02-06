self: super:
with super.pkgs;
{
    # See https://github.com/NixOS/nixpkgs/issues/10597#issuecomment-313908853
    pythonEnv = pkgs.buildEnv {
      name = "pythonEnv";
      paths = [
        (with python27Packages; python.buildEnv.override {
          extraLibs = [
            pip
            virtualenv
          ];
        })
          (with python3Packages; python.buildEnv.override {
          extraLibs = [
            flake8
            pip
            pyyaml
            requests
          ];
        })
          xonsh
          pipenv
        ];
    };
}
