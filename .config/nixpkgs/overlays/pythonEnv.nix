self: super:
with super.pkgs;
{
    my_xonsh = pkgs.xonsh.overrideAttrs (oldAttrs: rec {
      # Check fails on macOS
      doInstallCheck = !stdenv.isDarwin;
      propagatedBuildInputs = with python3Packages; [
        ply
        prompt_toolkit
        pyyaml
        requests
      ];
    });

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
          my_xonsh
          pipenv
        ];
    };
}
