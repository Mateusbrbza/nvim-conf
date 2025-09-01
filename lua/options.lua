require "nvchad.options"

-- add yours here!
local opts = {}
opts["scope"] = "global"

-- vim.opt.relativenumber = true
vim.api.nvim_set_option_value("colorcolumn", "90", opts)

-- vim.api.nvim_create_autocmd({ "BufWritePre" }, {
--   pattern = { "*" },
--   command = [[%s/\s\+$//e]],
-- })
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = {"*"},
    callback = function()
      local save_cursor = vim.fn.getpos(".")
      pcall(function() vim.cmd [[%s/\s\+$//e]] end)
      vim.fn.setpos(".", save_cursor)
    end,
})
