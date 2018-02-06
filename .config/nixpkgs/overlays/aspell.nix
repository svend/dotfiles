self: super:
with super.pkgs;
{
  my_aspell = aspellWithDicts(ps: with ps; [ en ]);
}
