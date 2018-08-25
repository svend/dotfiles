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

      (with python37Packages; python.buildEnv.override {
        extraLibs = [
          black
          flake8
          isort
          pip
          # pylint # astroid-2.0.1 FTB on Python 3.7
          pyyaml
          # requests # hypothesis-3.66.2 FTB on Python 3.7
        ];
      })

      xonsh
      # pipenv # Error while finding module specification for 'pipenv.pew' (ModuleNotFoundError: No module named 'pipenv')
    ];
  };
}
