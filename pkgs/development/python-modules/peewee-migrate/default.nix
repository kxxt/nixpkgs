{ lib
, buildPythonPackage
, fetchFromGitHub
, pythonOlder

# build-system
, poetry-core

# runtime
, click
, peewee

# tests
, psycopg2
, pytestCheckHook
}:

buildPythonPackage rec {
  pname = "peewee-migrate";
  version = "1.10.0";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "klen";
    repo = "peewee_migrate";
    rev = "refs/tags/${version}";
    hash = "sha256-YDL7J/LmCRz6kRHQ0NrnVnvtS3rFkH08umjPI95mn6w=";
  };

  nativeBuildInputs = [
    poetry-core
  ];

  postPatch = ''
    sed -i '/addopts/d' pyproject.toml
  '';

  propagatedBuildInputs = [
    peewee
    click
  ];

  pythonImportsCheck = [
    "peewee_migrate"
  ];

  nativeCheckInputs = [
    psycopg2
    pytestCheckHook
  ];

  meta = with lib; {
    description = "Simple migration engine for Peewee";
    homepage = "https://github.com/klen/peewee_migrate";
    license = licenses.bsd3;
    maintainers = with maintainers; [ hexa ];
  };
}
