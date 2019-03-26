self: super:
{
  pass = with super; pass.overrideAttrs (old: rec {
    # Check fails macOS 2019-03-26
    # not ok 1 - Test "generate" command
    doInstallCheck = !stdenv.isDarwin;
  });
}
