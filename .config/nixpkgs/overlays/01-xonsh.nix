self: super:
{
  xonsh = with super; xonsh.overrideAttrs (old: rec {
    # Check fails macOS 2019-03-26
    # AttributeError: module 'builtins' has no attribute '__xonsh__'
    doInstallCheck = !stdenv.isDarwin;
    propagatedBuildInputs = with python3Packages; [ ply prompt_toolkit pygments
      pyyaml
      requests
    ];
  });
}
