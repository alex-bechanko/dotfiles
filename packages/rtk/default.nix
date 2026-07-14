{
  lib,
  rustPlatform,
  src,
}:
rustPlatform.buildRustPackage {
  pname = "rtk";
  version = (lib.importTOML "${src}/Cargo.toml").package.version;

  inherit src;

  # The upstream repo ships a Cargo.lock and depends only on crates.io
  # registry crates (no git dependencies), so we can vendor straight from
  # the lockfile instead of maintaining a cargoHash.
  cargoLock.lockFile = "${src}/Cargo.lock";

  # The test suite shells out to real tools (git, curl), writes to $HOME, and
  # expects network access, so it can't run inside the Nix build sandbox.
  doCheck = false;

  meta = {
    description = "Rust Token Killer - high-performance CLI proxy to minimize LLM token consumption";
    homepage = "https://github.com/rtk-ai/rtk";
    license = lib.licenses.asl20;
    mainProgram = "rtk";
  };
}
