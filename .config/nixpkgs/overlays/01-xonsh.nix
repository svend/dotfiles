self: super:
{
  xonsh = with super; xonsh.overrideAttrs (old: rec {
    # Check fails macOS and Linux 2018-06-10
    doInstallCheck = false;
    propagatedBuildInputs = with python3Packages; [
      ply
      prompt_toolkit
      pyyaml
      requests
    ];
  });
}
