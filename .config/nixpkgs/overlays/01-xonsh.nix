self: super:
{
  xonsh = with super; xonsh.overrideAttrs (old: rec {
    # Check fails macOS and Linux 2018-06-10
    # AttributeError: module 'builtins' has no attribute '__xonsh__'
    doInstallCheck = false;
    propagatedBuildInputs = with python3Packages; [ ply prompt_toolkit pygments
      pyyaml
      requests
    ];
  });
}
