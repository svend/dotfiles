self: super:
{
  kubernetesEnv = with self; super.buildEnv {
    name = "kubernetesEnv";
    paths = [
      helm
      kubernetes
    ];
  };
}
