self: super:
{
  # pipenv = with super; with python3Packages; pipenv.overrideAttrs (old: rec {
  #   name = "${pname}-${version}";
  #   pname = "pipenv";
  #   version = "10.1.2";

  #   src = fetchPypi {
  #     inherit pname version;
  #     sha256 = "ce6dbb305fb1f262dba0dcb50c06591e4d146f7bfe079cc9f0ce3f89c7516ae9";
  #   };

  #   LC_ALL = "en_US.UTF-8";

  #   propagatedBuildInputs = [ pew pip requests flake8 ];
  # });
}
