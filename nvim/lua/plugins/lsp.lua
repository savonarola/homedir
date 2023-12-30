return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- pyright will be automatically installed with mason and loaded with lspconfig
        erlangls = {},
      },
      setup = {
        erlangls = function(_, opts)
          local lspconfig = require("lspconfig")
          opts.root_dir = lspconfig.util.root_pattern("erlang_ls.config")
        end,
      },
    },
  },
}
