{
  lib,
  buildPythonPackage,
  chardet,
  diff-match-patch,
  django,
  fetchFromGitHub,
  psycopg2,
  python,
  pytz,
  setuptools-scm,
  tablib,
}:

buildPythonPackage rec {
  pname = "django-import-export";
  version = "4.3.9";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "django-import-export";
    repo = "django-import-export";
    tag = version;
    hash = "sha256-qcxvXq+pC2leDhaeor2hrWll8bQ+x6xN99pDlnmtUic=";
  };

  pythonRelaxDeps = [ "tablib" ];

  build-system = [ setuptools-scm ];

  dependencies = [
    diff-match-patch
    django
    tablib
  ];

  optional-dependencies = {
    all = [ tablib ] ++ tablib.optional-dependencies.all;
    cli = [ tablib ] ++ tablib.optional-dependencies.cli;
    ods = [ tablib ] ++ tablib.optional-dependencies.ods;
    pandas = [ tablib ] ++ tablib.optional-dependencies.pandas;
    xls = [ tablib ] ++ tablib.optional-dependencies.xls;
    xlsx = [ tablib ] ++ tablib.optional-dependencies.xlsx;
    yaml = [ tablib ] ++ tablib.optional-dependencies.yaml;
  };

  nativeCheckInputs = [
    chardet
    psycopg2
    pytz
  ]
  ++ lib.flatten (builtins.attrValues optional-dependencies);

  checkPhase = ''
    runHook preCheck
    ${python.interpreter} tests/manage.py test core --settings=settings
    runHook postCheck
  '';

  pythonImportsCheck = [ "import_export" ];

  meta = with lib; {
    description = "Django application and library for importing and exporting data with admin integration";
    homepage = "https://github.com/django-import-export/django-import-export";
    changelog = "https://github.com/django-import-export/django-import-export/blob/${src.tag}/docs/changelog.rst";
    license = licenses.bsd2;
    maintainers = with maintainers; [ sephi ];
  };
}
