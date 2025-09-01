require("mason-conform").setup({
    ensure_installed = {
        "stylua",
        "prettier",
        "eslint",
    },
    ignore_install = { "prettier" }, -- List of formatters to ignore during install
    automatic_installation = true, -- Automatically install missing formatters
})
