# self: super:
# {
#   nixStable = with super; nixStable.overrideAttrs (old: rec {
#     name = "nix-2.0";
#     src = fetchurl {
#       url = "http://nixos.org/releases/nix/${name}/${name}.tar.xz";
#       sha256 = "052s5ylia0gvdc1m8f894i5s8a4qj92dkk3c7qfjryab64kx693h";
#     };
#   });
# }
