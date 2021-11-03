vim.g.mapleader = ","

require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  use {
    'neovim/nvim-lspconfig',
    'williamboman/nvim-lsp-installer',
  }

  use { 'ms-jpq/coq_nvim', branch = 'coq' }
  use { 'ms-jpq/coq.artifacts', branch = 'artifacts' }
  use { 'ms-jpq/coq.thirdparty', branch = '3p' }

  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim', 'nvim-lua/popup.nvim'} }
  }

  use {'akinsho/bufferline.nvim', requires = 'kyazdani42/nvim-web-devicons'}

  use { 'kyazdani42/nvim-tree.lua', requires = 'kyazdani42/nvim-web-devicons', }

  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }

  use 'b3nj5m1n/kommentary'

  use 'sbdchd/neoformat'

  use "Pocco81/AutoSave.nvim"

  use 'elixir-lang/vim-elixir'
  use 'chr4/nginx.vim'
  use 'Mofiqul/vscode.nvim'
  use 'lukas-reineke/indent-blankline.nvim'

end)

--------------------------------------------------------------------------------
-- AutoSave
--------------------------------------------------------------------------------

require("autosave").setup()

--------------------------------------------------------------------------------
-- Kommentary
--------------------------------------------------------------------------------

vim.api.nvim_set_keymap("n", "<leader>cc", "<Plug>kommentary_line_increase", {})
vim.api.nvim_set_keymap("n", "<leader>cu", "<Plug>kommentary_line_decrease", {})
vim.api.nvim_set_keymap("x", "<leader>cc", "<Plug>kommentary_visual_increase", {})
vim.api.nvim_set_keymap("x", "<leader>cu", "<Plug>kommentary_visual_decrease", {})

--------------------------------------------------------------------------------
-- Telescope
--------------------------------------------------------------------------------

require("telescope").setup()
vim.cmd [[
  nnoremap <leader>p <cmd>Telescope find_files<cr>
  nnoremap <leader>fg <cmd>Telescope live_grep<cr>
  nnoremap <leader>b <cmd>Telescope buffers<cr>
  nnoremap <leader>fh <cmd>Telescope help_tags<cr>
]]

--------------------------------------------------------------------------------
-- Neoformat
--------------------------------------------------------------------------------

vim.g.neoformat_erlang_erlfmt = { exe = "erlfmt" }
vim.g.neoformat_enabled_erlang = { "erlfmt" }

--------------------------------------------------------------------------------
-- COQ completion
--------------------------------------------------------------------------------

require("coq")
vim.cmd [[COQnow -s]]

--------------------------------------------------------------------------------
-- General customizations
--------------------------------------------------------------------------------

vim.g.vscode_style = "dark"

vim.cmd [[
  set undodir=~/.vim/undo
  set undofile

	set novisualbell
	set t_vb=
	set nobackup
	set noswapfile

	set number
  colorscheme vscode
]]

--------------------------------------------------------------------------------
-- nvim-tree
--------------------------------------------------------------------------------

require("nvim-tree").setup()
vim.cmd [[
  nnoremap <leader>t <cmd>NvimTreeToggle<cr>
]]

