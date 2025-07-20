return {
  settings = {
    ['rust-analyzer'] = {
      diagnostics = {
        enable = false,
      },
      checkOnSave = {
        allFeatures = true,
        command = "clippy",
        extraArgs = {
          "--",
          "--no-deps",
          "-Dclippy::correctness",
          "-Dclippy::complexity",
          "-Wclippy::perf",
          "-Wclippy::pedantic",
        },
      },
    },
  }
}
