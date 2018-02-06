self: super:
{
    # Mac-specific packages
    macEnv = with self; super.buildEnv {
      name = "macEnv";
      paths = [
        terminal-notifier
        pinentry_mac
      ];
    };
}
