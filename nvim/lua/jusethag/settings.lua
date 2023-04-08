-- Change leader key (From '\' to space)
vim.g.mapleader = " "


-- Enable line number
vim.opt.number = true

-- Avoid disable Vim-specific features
vim.opt.compatible = false

-- Avoid save prompt when moving between buffers 
vim.opt.hidden = true

-- Too obvious but for setting encoding
vim.opt.encoding = 'utf-8'

-- Set case insensitive searching
vim.opt.ignorecase = true

-- Set case sensitive searching when not all lowercase
vim.opt.smartcase = true

-- Show sign column
vim.opt.signcolumn = 'yes'
