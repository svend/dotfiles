{ stdenv, python3Packages }:

with python3Packages;

buildPythonPackage rec {
  name = "${pname}-${version}";
  pname = "black";
  version = "18.4a0";

  src = fetchPypi {
    inherit pname version;
    sha256 = "04dffr4wmzs4vf2xj0cxp03hv04x0kk06qyzx6jjrp1mq0z3n2rr";
  };

  propagatedBuildInputs = [ attrs click ];

  meta = with stdenv.lib; {
    description = "The uncompromising Python code formatter";
    homepage = https://github.com/ambv/black;
    license = licenses.mit;
  };
}
