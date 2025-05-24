vim.g.mapleader = ","

-- vim.g.clipboard = {
--   name = 'OSC 52',
--   copy = {
--     ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
--     ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
--   },
--   paste = {
--     ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
--     ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
--   },
-- }

vim.cmd [[packadd packer.nvim]]

require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim', 'nvim-lua/popup.nvim'} },
    config = function()
      require("telescope").setup()
      vim.cmd [[
        nnoremap <leader>fp <cmd>Telescope find_files<cr>
        nnoremap <leader>fg <cmd>Telescope live_grep<cr>
        nnoremap <leader>fb <cmd>Telescope buffers<cr>
        nnoremap <leader>fh <cmd>Telescope help_tags<cr>
      ]]
    end
  }

  use 'junegunn/fzf'
  use {
    'junegunn/fzf.vim',
    config = function()
      vim.cmd [[
        let $FZF_DEFAULT_COMMAND = 'rg --files --hidden -g "!.git"'
        nnoremap <leader>p <cmd>FZF<cr>
        nnoremap <leader>b <cmd>Buffers<cr>
      ]]
    end
  }

  use {
    'ibhagwan/fzf-lua',
    config = function()
      vim.cmd [[
        nnoremap <leader>g <cmd>FzfLua live_grep<cr>
      ]]

      local actions = require("fzf-lua.actions")
      require('fzf-lua').setup({
        grep = {
          rg_opts = "--column --line-number --no-heading --color=always --smart-case --max-columns=512 --hidden -g \"!.git\" "
        }
      })
    end
  }

  use {
    'kyazdani42/nvim-tree.lua',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function()
      require("nvim-tree").setup()
      vim.cmd [[
        nnoremap <leader>t <cmd>NvimTreeToggle<cr>
      ]]
    end
  }

  use {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require("gitsigns").setup()
    end
  }

  use {
    'nvim-lualine/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons'},
    config = function()
      local powerline_dark = require('lualine.themes.powerline_dark')
      require('lualine').setup{
        options = { theme  = powerline_dark }
      }
    end
  }

  use {
    'b3nj5m1n/kommentary',
    config = function()
      vim.api.nvim_set_keymap("n", "<leader>cc", "<Plug>kommentary_line_increase", {})
      vim.api.nvim_set_keymap("n", "<leader>cu", "<Plug>kommentary_line_decrease", {})
      vim.api.nvim_set_keymap("x", "<leader>cc", "<Plug>kommentary_visual_increase", {})
      vim.api.nvim_set_keymap("x", "<leader>cu", "<Plug>kommentary_visual_decrease", {})
    end
  }

  use {
    'sbdchd/neoformat',
    config = function()
      vim.g.neoformat_erlang_erlfmt = { exe = "erlfmt" }
      vim.g.neoformat_enabled_erlang = { "erlfmt" }
    end
  }

  use {
    "Pocco81/auto-save.nvim",
    config = function()
      require("auto-save").setup()
    end
  }

  use 'elixir-lang/vim-elixir'
  use 'chr4/nginx.vim'

  use {
    'Mofiqul/vscode.nvim',
    config = function()
      vim.g.vscode_style = "dark"
      vim.cmd [[colorscheme vscode]]
    end
  }

end)

vim.cmd [[
  set undodir=~/.vim-undo
  set undofile

	set novisualbell
	set t_vb=
	set nobackup
	set noswapfile

	set number

  if has("unnamedplus")
    set clipboard=unnamedplus
  endif

  nmap <c-c> "+y
  vmap <c-c> "+y
  inoremap <c-v> <c-r>+
  cnoremap <c-v> <c-r>+
  inoremap <c-r> <c-v>

  map Q <Nop>

  vmap > >gv
  vmap < <gv

  set grepprg=rg\ --vimgrep\ --no-heading\ --hidden\ --smart-case
  set grepformat=%f:%l:%c:%m
]]

