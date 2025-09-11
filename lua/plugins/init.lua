return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    cmd = "CopilotChat",
    keys = {
      {
        "<c-s>",
        "<CR>",
        ft = "copilot-chat",
        desc = "Submit Prompt",
        remap = true,
      },
      {
        "<leader>a",
        "",
        desc = "+ai",
        mode = {
          "n",
          "v",
        },
      },
      {
        "<leader>aa",
        function()
          return require("CopilotChat").toggle()
        end,
        desc = "Toggle (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        "<leader>aX",
        function()
          return require("CopilotChat").reset()
        end,
        desc = "Clear (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        "<leader>ai",
        function()
          local input = vim.fn.input "Quick Chat: "
          if input ~= "" then
            require("CopilotChat").ask(input)
          end
        end,
        desc = "Quick Chat (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        "<leader>ax",
        "<CMD>CopilotChatExplain<CR>",
        desc = "Explain (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        "<leader>ar",
        "<CMD>CopilotChatReview<CR>",
        desc = "Review (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        "<leader>af",
        "<CMD>CopilotChatFix<CR>",
        desc = "Fix (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        "<leader>ao",
        "<CMD>CopilotChatOptimize<CR>",
        desc = "Optimize (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        "<leader>aD",
        "<CMD>CopilotChatDocs<CR>",
        desc = "Doc (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        "<leader>at",
        "<CMD>CopilotChatTests<CR>",
        desc = "Generate Tests (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        "<A-c>",
        "<CMD>CopilotChatToggle<CR>",
        desc = "Toggle (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        "<A-m>",
        "<CMD>CopilotChatToggle<CR>",
        desc = "Toggle (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        "<leader>an",
        function()
          local buffers = vim.api.nvim_list_bufs()
          local filenames = {}
          for _, buf in ipairs(buffers) do
            if vim.api.nvim_buf_is_loaded(buf) then
              local filename = vim.api.nvim_buf_get_name(buf)
              table.insert(filenames, "> #file:" .. filename)
            end
          end
          local prompt = table.concat(filenames, "\n")
          vim.fn.setreg("+", prompt)
          vim.notify(
            "Files added to clipboard: " .. table.concat(filenames, ", "),
            vim.log.levels.INFO
          )
        end,
        desc = "Include Buffers in Prompt",
        mode = { "n", "v" },
      },
    },
    config = function(_, opts)
      local chat = require "CopilotChat"

      opts.chat_autocomplete = true

      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "copilot-chat",
        callback = function()
          vim.opt_local.relativenumber = false
          vim.opt_local.number = false
        end,
      })

      opts.mappings = {
        complete = {
          detail = "Use @<Tab> or /<Tab> for options.",
          insert = "<Tab>",
        },
        close = {
          normal = "q",
          insert = "<C-c>",
        },
        reset = {
          normal = "<C-c>",
          insert = "",
        },
        submit_prompt = {
          normal = "<CR>",
          insert = "<C-m>",
        },
        accept_diff = {
          normal = "<C-y>",
          insert = "<C-y>",
        },
        yank_diff = {
          normal = "gy",
        },
        show_diff = {
          normal = "gd",
        },
        show_info = {
          normal = "gp",
        },
        show_context = {
          normal = "gs",
        },
      }

      chat.setup(opts)
    end,
  },

  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },

  {
    "github/copilot.vim",
    lazy = false,
    enabled = true,
    opts = {
      panel = {
        auto_refresh = true,
        layout = {
          position = "right",
          ratio = 0.3,
        },
      },
      suggestion = {
        auto_trigger = true,
        keymap = {
          accept = "<C-l>",
        },
      },
    },
    config = function()
      -- Mapping tab is already used by NvChad
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true
      vim.g.copilot_tab_fallback = ""
      -- The mapping is set to other key, see custom/lua/mappings
      -- or run <leader>ch to see copilot mapping section
    end,
  },

  {
    "nvim-lua/plenary.nvim",
  },

  {
    "nvimtools/none-ls.nvim",
    event = "VeryLazy",
    opts = function()
      return require "configs.null-ls"
    end,
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "windwp/nvim-ts-autotag",
    ft = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "html",
    },
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "bash", "json", "toml", "ini" }, -- Add parsers you want
      highlight = { enable = true },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
      -- Associate .env and .config files with 'sh' (bash) or other filetype
      vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
        pattern = { ".env", ".config" },
        callback = function()
          vim.bo.filetype = "sh" -- or "ini", "toml", etc. as appropriate
        end,
      })
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "typescript-language-server",
        "lua-language-server",
        "tailwindcss-language-server",
        "eslint-lsp",
        "prettierd",
        "gopls"
      },
    },
  },

  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    config = function()
      return require "configs.conform"
    end,
  },

  {
    "zapling/mason-conform.nvim",
    event = "VeryLazy",
    dependencies = { "conform.nvim" },
    config = function()
      return require "configs.mason-conform"
    end,
  },

  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      return require "configs.lint"
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-lspconfig" },
    config = function()
      return require "configs.mason-lspconfig"
    end,
  },

  {
    "rshkarin/mason-nvim-lint",
    event = "VeryLazy",
    dependencies = { "nvim-lint" },
    config = function()
      return require "configs.mason-nvim-lint"
    end,
  },

  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim"
    }
  },
}
