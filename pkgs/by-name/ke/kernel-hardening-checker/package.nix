{
  lib,
  python3Packages,
  fetchFromGitHub,
}:

python3Packages.buildPythonApplication rec {
  pname = "kernel-hardening-checker";
  version = "0.6.10";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "a13xp0p0v";
    repo = "kernel-hardening-checker";
    rev = "v${version}";
    hash = "sha256-gxDaOb14jFezxe/qHZF3e52o7obVL0WMIKxwIj3j5QY=";
  };

  build-system = with python3Packages; [ setuptools ];

  pythonImportsCheck = [ "kernel_hardening_checker" ];

  meta = with lib; {
    description = "Tool for checking the security hardening options of the Linux kernel";
    homepage = "https://github.com/a13xp0p0v/kernel-hardening-checker";
    license = licenses.gpl3Only;
    platforms = platforms.all;
    maintainers = with maintainers; [ erdnaxe ];
    mainProgram = "kernel-hardening-checker";
  };
}
