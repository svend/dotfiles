self: super:
{
  xonsh = with super; xonsh.overrideAttrs (old: rec {
    # Check fails on macOS
    doInstallCheck = !stdenv.isDarwin;
    propagatedBuildInputs = with python3Packages; [
      ply
      prompt_toolkit
      pyyaml
      requests
    ];
  });
}
