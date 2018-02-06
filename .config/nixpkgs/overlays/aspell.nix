self: super:
{
  my_aspell = super.pkgs.aspellWithDicts(ps: with ps; [ en ]);
}
