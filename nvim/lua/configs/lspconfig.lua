require("nvchad.configs.lspconfig").defaults()

local servers = {
  "elp",      -- Erlang Language Platform
  "lexical",  -- Elixir LSP
}
vim.lsp.enable(servers)

vim.diagnostic.config({
  virtual_text = {
    severity = { min = vim.diagnostic.severity.WARN },
  },
  signs = {
    severity = { min = vim.diagnostic.severity.INFO },
  },
  float = {
    severity = { min = vim.diagnostic.severity.HINT },
  },
  underline = {
    severity = { min = vim.diagnostic.severity.WARN },
  },
  severity = {
    min = vim.diagnostic.severity.WARN,
  },
})


-- read :h vim.lsp.config for changing options of lsp servers 
