return {
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
    },
  },
  root_dir = function(fname)
    return require("lspconfig").util.root_pattern("go.work", "go.mod", ".git")(fname)
  end,
}
