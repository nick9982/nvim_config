require('settings.init')
require('plugins.plugins')
require('plugins.nvtree')
require('plugins.tabs')
require('plugins.treesitter')
require('mappings.init')
require('plugins.lsp_conf')
require('mappings.syntax')
require('mappings.splits')
require('mappings.build_runcpp')
require('mappings.macros')

vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme gruvbox]])
