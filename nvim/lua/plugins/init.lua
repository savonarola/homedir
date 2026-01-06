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
  },

  -- Flash - navigate with search labels
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      modes = {
        search = {
          enabled = true,
        },
        char = {
          enabled = false,
        },
      },
    },
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "S",
        mode = { "n", "x", "o" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
      {
        "r",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote Flash",
      },
      {
        "R",
        mode = { "o", "x" },
        function()
          require("flash").treesitter_search()
        end,
        desc = "Treesitter Search",
      },
      {
        "<c-s>",
        mode = { "c" },
        function()
          require("flash").toggle()
        end,
        desc = "Toggle Flash Search",
      },
    },
  },

  {
    "Yu-Leo/blame-column.nvim",
    opts = {}, -- for default options. Refer to the configuration section for custom setup.
    cmd = "BlameColumnToggle",
  },

  -- {
  --   "Mofiqul/vscode.nvim",
  --   opts = {},
  -- }

}
