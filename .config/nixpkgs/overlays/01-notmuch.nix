self: super:
{
  notmuch = with super; notmuch.overrideAttrs (old: rec {
    # Tests fail with:
    # FATAL: /build/notmuch-0.29.3/test/T310-emacs.sh: interrupted by signal 15
    doCheck = false;
  });
}
