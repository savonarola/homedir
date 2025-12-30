return {
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
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim", "lua", "vimdoc",
        "html", "css",
        "elixir", "python", "rust", "go",
        "c", "cpp", "erlang", "bash",
      },
    },
  },

  -- Minuet AI completion
  {
    "milanglacier/minuet-ai.nvim",
    event = "InsertEnter",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      require("configs.minuet")
    end,
  },

  -- Override nvim-cmp to add minuet source
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")

      opts.sources = opts.sources or {}
      table.insert(opts.sources, 1, {
        name = "minuet",
        group_index = 1,
        priority = 100,
      })

      opts.performance = opts.performance or {}
      opts.performance.fetching_timeout = 3000

      opts.mapping = opts.mapping or {}
      opts.mapping["<A-Tab>"] = require("minuet").make_cmp_map()

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
  }

}
