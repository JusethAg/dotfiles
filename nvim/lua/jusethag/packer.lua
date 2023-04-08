local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'


  -- Neovim theme
  -- GitHub: https://github.com/shaunsingh/moonlight.nvim
  use 'shaunsingh/moonlight.nvim'


  -- File explorer for Neovim
  -- GitHub: https://github.com/nvim-tree/nvim-tree.lua
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional
    },
    config = function()
      require("nvim-tree").setup {}
    end
  }


  -- Status line
  -- GitHub: https://github.com/nvim-lualine/lualine.nvim 
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }


  -- Neovim web icons
  -- GitHub: https://github.com/nvim-tree/nvim-web-devicons 
  use 'nvim-tree/nvim-web-devicons'


  -- Fuzzy finder over list
  -- GitHub: https://github.com/nvimtelescope/telescope.nvim
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.1',
    requires = { {'nvim-lua/plenary.nvim'} }
  }


  -- Native telescope sorter
  -- GitHub: https://github.com/nvim-telescope/telescope-fzf-native.nvim
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }


  -- Preview markdown
  -- GitHub
  use {'ellisonleao/glow.nvim', config = function() require('glow').setup() end}

  -- Interface of tree-sitter  
  -- GitHub: https://github.com/nvim-treesitter/nvim-treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }


  -- Bundle all the "boilerplate code" necessary to have nvim-cmp and nvim-lspconfig working together
  -- GitHub: https://github.com/VonHeikemen/lsp-zero.nvim
  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    requires = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},             -- Required
      {                                      -- Optional
        'williamboman/mason.nvim',
        run = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
      {'williamboman/mason-lspconfig.nvim'}, -- Optional

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},     -- Required
      {'hrsh7th/cmp-nvim-lsp'}, -- Required
      {'L3MON4D3/LuaSnip'},     -- Required
    }
  }


  -- Automatically set up your configuration after cloning packer.nvim
  if packer_bootstrap then
    require('packer').sync()
  end
end)
