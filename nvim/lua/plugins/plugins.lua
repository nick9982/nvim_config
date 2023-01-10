local fn = vim.fn

local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.vim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }
    print "Installing packer close and reopen Neovim..."
    vim.cmd [[packadd packer.nvim]]
end

vim.cmd [[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua | PackerSync
    augroup end
]]

packer = require "packer"
--local status_ok, packer = pcall(require "packer")
--if not status_ok then
--    return
--end

packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float {border = "rounded"}
        end,
    },
}

local use = packer.use
packer.reset()

return packer.startup(function(use)
    --Plugins
    use "wbthomason/packer.nvim"
    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional, for file icons
        },
        tag = 'nightly' -- optional, updated every week. (see issue #1193)
    }
    use "terrortylor/nvim-comment"
    require('nvim_comment').setup()
    use { 'ibhagwan/fzf-lua',
        requires = { 'nvim-tree/nvim-web-devicons' }
    }
    
    use {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
    }

    use "mfussenegger/nvim-dap"

    use "nvim-lua/plenary.nvim"

    use({
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
            require("null-ls").setup()
        end,
        requires = { "nvim-lua/plenary.nvim" },
    })

    require("mason").setup({
        ui = {
            border = "single",
        },
    })

    --new plugins <<MAY CAUSE ERROR>>
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-cmdline"
    use "hrsh7th/nvim-cmp"
    use "L3MON4D3/LuaSnip"
    use "saadparwaiz1/cmp_luasnip"
    
    local cmp = require'cmp'

    cmp.setup({
        snippet = {
            expand = function(args)
                require('luasnip').lsp_expand(args.body)
            end,
        },
        window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
            { name = 'nvim_lisp' },
            { name = 'luasnip' },
        }, {
            { name = 'buffer' },
        })
    })

    cmp.setup.cmdline({'/', '?'}, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = 'buffer' }
        }
    })

    cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            { name = 'path' },
        }, {
            { name = 'cmdline' }
        })
    }) 

    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    require('lspconfig').pyright.setup({
        capabilities = capabilities
    })

    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'saadparwaiz1/cmp_luasnip'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-nvim-lua'},

            -- Snippets
            {'L3MON4D3/LuaSnip'},
            {'rafamadriz/friendly-snippets'},
        }
    }
        
    local lsp = require('lsp-zero')

    lsp.preset('recommended')
    lsp.setup()

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    use 'nvim-tree/nvim-web-devicons'
    use {'romgrk/barbar.nvim', wants = 'nvim-web-devicons'}

    use 'vim-airline/vim-airline'

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }
    use 'ellisonleao/gruvbox.nvim'

    use 'terryma/vim-multiple-cursors'

    --After plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
