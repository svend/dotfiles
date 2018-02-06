self: super:
with super.pkgs;
{
    rustEnv = pkgs.buildEnv {
      name = "rustEnv";
      paths = [
        cargo
        rustc
      ];
      buildInputs = [
        cargo
        rustc
      ];
    };
}
