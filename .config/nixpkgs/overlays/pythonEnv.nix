self: super:
{
  # See https://github.com/NixOS/nixpkgs/issues/10597#issuecomment-313908853
  pythonEnv = with self; super.buildEnv {
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
          black
          flake8
          isort
          pip
          pylint # 2018-11-26 FTB on pylint tests
          pyyaml
          requests
        ];
      })

      # xonsh # https://github.com/NixOS/nixpkgs/issues/51019
      # pipenv # Error while finding module specification for 'pipenv.pew' (ModuleNotFoundError: No module named 'pipenv')
    ];
  };
}
