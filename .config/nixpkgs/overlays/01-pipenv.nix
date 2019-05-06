self: super:
{
  pipenv = with super; with python3Packages; pipenv.overrideAttrs (old: rec {
    # https://github.com/NixOS/nixpkgs/pull/61044
    propagatedBuildInputs = [
      flake8
      invoke
      parver
      pip
      requests
      virtualenv
      virtualenv-clone
    ];
  });
}
