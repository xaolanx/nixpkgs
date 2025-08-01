{
  lib,
  rustPlatform,
  fetchCrate,
}:

rustPlatform.buildRustPackage rec {
  pname = "svlint";
  version = "0.9.3";

  src = fetchCrate {
    inherit pname version;
    hash = "sha256-u61gmkO7eij7r1A1RPk0ro+pml7ZmMsg0ukJLCFNaD0=";
  };

  cargoHash = "sha256-0vL9fdZqxGleEPTXq+/R+1GzqD91ZTgwt2C8sx0kUbM=";

  cargoBuildFlags = [
    "--bin"
    "svlint"
  ];

  meta = {
    description = "SystemVerilog linter";
    mainProgram = "svlint";
    homepage = "https://github.com/dalance/svlint";
    changelog = "https://github.com/dalance/svlint/blob/v${version}/CHANGELOG.md";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ trepetti ];
  };
}
