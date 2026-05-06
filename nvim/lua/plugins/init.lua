return {
  -- Disable which-key
  {
    "folke/which-key.nvim",
    enabled = false,
  },

  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  {
    "savonarola/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim", "lua", "vimdoc",
        "html", "css",
        "elixir", "python", "rust", "go",
        "c", "cpp", "erlang", "bash",
        "markdown", "query"
      },
    },

  },

  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")

      opts.mapping = opts.mapping or {}

      -- Arrow keys to navigate completion menu
      opts.mapping["<Down>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        else
          fallback()
        end
      end, { "i", "s" })

      opts.mapping["<Up>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        else
          fallback()
        end
      end, { "i", "s" })

      return opts
    end,
  },

  {
    "Yu-Leo/blame-column.nvim",
    opts = {}, -- for default options. Refer to the configuration section for custom setup.
    cmd = "BlameColumnToggle",
  },

}
