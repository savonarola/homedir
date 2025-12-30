require("nvchad.configs.lspconfig").defaults()

local servers = {
  "elp",      -- Erlang Language Platform
  "lexical",  -- Elixir LSP
}
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers 
