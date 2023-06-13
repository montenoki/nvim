local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local packer_bootstrap

-- Packer: Auto install
if fn.empty(fn.glob(install_path)) > 0 then
    vim.notify('Installing Packer.nvim... Please wait...')
    packer_bootstrap =
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    local rtp_addition = vim.fn.stdpath('data') .. '/site/pack/*/start/*'
    if not string.find(vim.o.runtimepath, rtp_addition) then
        vim.o.runtimepath = rtp_addition .. ',' .. vim.o.runtimepath
    end
    vim.notify('Installation Done')
end

local packer = requirePlugin('packer')
if packer == nil then
    return
end

packer.startup({
    function(use)
        use('wbthomason/packer.nvim')

        -- Speed up loading Lua modules in Neovim to improve startup time.
        use('lewis6991/impatient.nvim')

        ----- Interface -----
        ---------------------

        -- Session manager
        use({
            'rmagatti/auto-session',
            config = function()
                require('plugin-config.interface.auto-session')
            end,
        })

        -- File Explorer
        use({
            'nvim-tree/nvim-tree.lua',
            requires = 'nvim-tree/nvim-web-devicons',
            config = function()
                require('plugin-config.interface.nvim-tree')
            end,
            tag = 'nightly',
        })

        -- Status Bar
        use({
            'nvim-lualine/lualine.nvim',
            requires = {
                'kyazdani42/nvim-web-devicons',
                opt = true,
            },
            config = function()
                require('plugin-config.interface.lualine')
            end,
        })

        --TODO:
        --.Tabs Bar
        use({
            'akinsho/bufferline.nvim',
            ag = '*',
            requires = { 'kyazdani42/nvim-web-devicons' },
            config = function()
                require('plugin-config.interface.bufferline')
            end,
        })

        use({
            'simrat39/symbols-outline.nvim',
            config = function()
                require('plugin-config.interface.symbols-outline')
            end,
        })

        -- Status for nvim-lsp progress
        use({
            'j-hui/fidget.nvim',
            config = function()
                require('plugin-config.interface.fidget')
            end,
            tag = 'legacy',
        })

        -- zen-mode
        use({
            'folke/zen-mode.nvim',
            config = function()
                require('plugin-config.interface.zen-mode')
            end,
        })

        -- Notice表示
        use({
            'rcarriga/nvim-notify',
            config = function()
                require('plugin-config.interface.nvim-notify')
            end,
        })

        -- Scroll Bar
        use({
            'petertriho/nvim-scrollbar',
            config = function()
                require('plugin-config.interface.scrollbar')
            end,
        })

        -- terminal表示
        use({
            'akinsho/toggleterm.nvim',
            tag = '*',
            config = function()
                require('plugin-config.interface.toggleterm')
            end,
        })

        ---------------------- interface -----------------------

        -- Which-key
        use({
            'folke/which-key.nvim',
            config = function()
                require('plugin-config.interface.whichkey')
            end,
        })

        ----- Color Schemes -----
        -------------------------

        use('Mofiqul/dracula.nvim')
        use('jeffkreeftmeijer/vim-dim')

        ----- Code Appearance  -----
        ----------------------------

        -- Highlighting
        use({
            'nvim-treesitter/nvim-treesitter',
            run = function()
                require('nvim-treesitter.install').update({
                    with_sync = true,
                })
            end,
            config = function()
                require('plugin-config.appearance.nvim-treesitter')
            end,
        })
        use({
            'nvim-treesitter/nvim-treesitter-textobjects',
            after = 'nvim-treesitter',
            requires = 'nvim-treesitter/nvim-treesitter',
        })
        use({
            'nvim-treesitter/nvim-treesitter-refactor',
            after = 'nvim-treesitter',
            requires = 'nvim-treesitter/nvim-treesitter',
        })

        -- To-do Comments.nvim
        use({
            'folke/todo-comments.nvim',
            requires = { 'nvim-lua/plenary.nvim' },
            config = function()
                require('plugin-config.appearance.todo-comments')
            end,
        })

        -- Indent-blankline
        use({
            'lukas-reineke/indent-blankline.nvim',
            config = function()
                require('plugin-config.appearance.indent-blankline')
            end,
        })

        -- Fold
        use({
            'kevinhwang91/nvim-ufo',
            requires = {
                'kevinhwang91/promise-async',
                {
                    'luukvbaal/statuscol.nvim',
                    config = function()
                        require('plugin-config.appearance.statuscol')
                    end,
                },
            },
            config = function()
                require('plugin-config.appearance.ufo')
            end,
        })

        use({
            'SmiteshP/nvim-navic',
            requires = 'neovim/nvim-lspconfig',
            config = function()
                require('plugin-config.appearance.navic')
            end,
        })

        -- Sticky Scroll
        use({
            'nvim-treesitter/nvim-treesitter-context',
            config = function()
                require('plugin-config.appearance.nvim-treesitter-context')
            end,
        })

        -- Color code display like: #ff0149
        use({
            'norcalli/nvim-colorizer.lua',
            config = function()
                require('plugin-config.appearance.colorizer')
            end,
        })

        -- git
        use({
            'lewis6991/gitsigns.nvim',
            config = function()
                require('plugin-config.appearance.gitsigns')
                require('scrollbar.handlers.gitsigns').setup()
            end,
        })

        ----- LSP -----
        ---------------

        use({ 'williamboman/mason.nvim' })
        use({ 'williamboman/mason-lspconfig.nvim' })
        use({ 'neovim/nvim-lspconfig' })
        use({
            'jose-elias-alvarez/null-ls.nvim',
            requires = 'nvim-lua/plenary.nvim',
        })

        -- TODO:
        -- -- Refactoring
        -- use({
        --     'ThePrimeagen/refactoring.nvim',
        --     requires = {
        --         { 'nvim-lua/plenary.nvim' },
        --         { 'nvim-treesitter/nvim-treesitter' },
        --     },
        -- })

        -- -- Lua
        use('folke/neodev.nvim')

        ----- Snippets -----
        --------------------

        -- Engine
        use('hrsh7th/nvim-cmp')
        use('SirVer/ultisnips')
        use('quangnguyen30192/cmp-nvim-ultisnips')
        use('onsails/lspkind-nvim')
        -- Source
        use('hrsh7th/cmp-nvim-lsp')
        use('hrsh7th/cmp-nvim-lsp-signature-help')
        use('hrsh7th/cmp-buffer')
        use('hrsh7th/cmp-path')
        use('hrsh7th/cmp-cmdline')
        use('dmitmel/cmp-cmdline-history')
        use('hrsh7th/cmp-emoji')
        -- 自分のsnippet
        use('montenoki/vim-snippets')

        ----- Editor -----
        ------------------

        -- Comment Toggle
        use({
            'numToStr/Comment.nvim',
            config = function()
                require('plugin-config.editor.comment')
            end,
        })

        -- Surround
        use({
            'kylechui/nvim-surround',
            config = function()
                require('plugin-config.editor.nvim-surround')
            end,
        })
        -- nvim-autopairs
        use({
            'windwp/nvim-autopairs',
            config = function()
                require('plugin-config.editor.nvim-autopairs')
            end,
        })

        ----- DAP -----
        ---------------
        use('mfussenegger/nvim-dap')
        use({
            'rcarriga/nvim-dap-ui',
            config = function()
                require('dapui').setup()
            end,
        })
        use('theHamsta/nvim-dap-virtual-text')

        ----- Search Tools -----
        ------------------------

        use({
            'nvim-telescope/telescope.nvim',
            tag = '0.1.1',
            requires = {
                'nvim-lua/plenary.nvim',
            },
            config = function()
                require('plugin-config.search.telescope')
            end,
        })
        use('LinArcX/telescope-env.nvim')
        use('LinArcX/telescope-command-palette.nvim')
        use('smartpde/telescope-recent-files')
        use('rmagatti/session-lens')

        -- project
        use({
            'ahmedkhalf/project.nvim',
            config = function()
                require('plugin-config.search.project')
            end,
        })

        -- Diagnostics 表示
        use({
            'folke/trouble.nvim',
            requires = 'nvim-tree/nvim-web-devicons',
            config = function()
                require('plugin-config.interface.trouble')
            end,
        })

        use({
            'phaazon/hop.nvim',
            branch = 'v2',
            config = function()
                require('plugin-config.search.hop')
            end,
        })

        -- -- Lua

        -- ---------------------- 検索機能 -----------------------

        -- --------------- Lang ----------------

        -- nvim lua
        -- use({ 'jbyuki/one-small-step-for-vimkind' })

        -- -- Python
        use({ 'luk400/vim-jukit' })
        -- use({
        --     'mfussenegger/nvim-dap-python',
        --     -- config = function()
        --     --     require('dap-python').setup()
        --     -- end,
        -- })

        -- -- JSON
        -- use('b0o/schemastore.nvim')

        -- Rust
        use('simrat39/rust-tools.nvim')

        -- -- -- cool movement
        -- -- use({
        -- --     'edluffy/specs.nvim',
        -- --     config = function()
        -- --         require('plugin-config.appearance.specs')
        -- --     end,
        -- -- })

        -- -- Mode color
        -- use({
        --     'mvllow/modes.nvim',
        --     tag = 'v0.2.0',
        --     config = function()
        --         require('plugin-config.appearance.modes')
        --     end,
        -- })

        -- -- serch highlight
        -- use({
        --     'kevinhwang91/nvim-hlslens',
        --     config = function()
        --         -- require('hlslens').setup() is not required
        --         require('scrollbar.handlers.search').setup({
        --             -- hlslens config overrides
        --         })
        --     end,
        -- })

        --------------- END ----------------
        if packer_bootstrap then
            packer.sync()
        end
    end,
    config = {
        max_jobs = 10,
        display = {
            open_fn = function()
                return require('packer.util').float({
                    border = 'single',
                })
            end,
        },
    },
})
