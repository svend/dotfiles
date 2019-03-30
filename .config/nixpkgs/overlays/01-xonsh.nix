self: super:
{
  xonsh = with super; xonsh.overrideAttrs (old: rec {
    # Check fails linux/macOS 2019-03-29
    # AttributeError: module 'builtins' has no attribute '__xonsh__'
    doInstallCheck = false;
    propagatedBuildInputs = with python3Packages; [ ply prompt_toolkit pygments
      pyyaml
      requests
    ];
  });
}
