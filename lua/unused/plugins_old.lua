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

vim.api.nvim_create_user_command(
    'PackerInstall',
    [[packadd packer.nvim | lua require("lua.plugins").install()]],
    { bang = true }
)
vim.api.nvim_create_user_command(
    'PackerUpdate',
    [[packadd packer.nvim | lua require("lua.plugins").update()]],
    { bang = true }
)
vim.api.nvim_create_user_command(
    'PackerSync',
    [[packadd packer.nvim | lua require("lua.plugins").sync()]],
    { bang = true }
)
vim.api.nvim_create_user_command(
    'PackerClean',
    [[packadd packer.nvim | lua require("lua.plugins").clean()]],
    { bang = true }
)
vim.api.nvim_create_user_command(
    'PackerCompile',
    [[packadd packer.nvim | lua require("lua.plugins").compile()]],
    { bang = true }
)

local packer

local function init()
    if not packer then
        packer = require('packer')
        packer.init({
            display = {
                open_fn = require('packer.util').float,
            },
        })
    end
    packer.reset()
    packer.use({

        { 'wbthomason/packer.nvim' },

        ----- Interface ----
        ---------------------

        -- Session manager
        {
            'rmagatti/auto-session',
            config = function()
                require('plugin-config.interface.auto-session')
            end,
        },

        -- File Explorer
        {
            'nvim-tree/nvim-tree.lua',
            requires = 'nvim-tree/nvim-web-devicons',
            config = function()
                require('plugin-config.interface.nvim-tree')
            end,
            tag = 'nightly',
        },

        -- Status Bar
        {
            'nvim-lualine/lualine.nvim',
            requires = {
                'kyazdani42/nvim-web-devicons',
                opt = true,
            },
            config = function()
                require('plugin-config.interface.lualine')
            end,
        },

        -- Tabs Bar
        {
            'akinsho/bufferline.nvim',
            ag = '*',
            requires = { 'kyazdani42/nvim-web-devicons' },
            config = function()
                require('plugin-config.interface.bufferline')
            end,
        },

        -- Outliner
        {
            'simrat39/symbols-outline.nvim',
            config = function()
                require('plugin-config.interface.symbols-outline')
            end,
        },

        -- Status for nvim-lsp progress
        {
            'j-hui/fidget.nvim',
            config = function()
                require('plugin-config.interface.fidget')
            end,
            tag = 'legacy',
        },

        -- Notice表示
        {
            'rcarriga/nvim-notify',
            config = function()
                require('plugin-config.interface.nvim-notify')
            end,
        },

        -- Scroll Bar
        {
            'petertriho/nvim-scrollbar',
            config = function()
                require('plugin-config.interface.scrollbar')
            end,
        },

        -- terminal表示
        {
            'akinsho/toggleterm.nvim',
            tag = '*',
            config = function()
                require('plugin-config.interface.toggleterm')
            end,
        },

        -- Which-key
        {
            'folke/which-key.nvim',
            config = function()
                require('plugin-config.interface.whichkey')
            end,
        },

        -- Diagnostics
        {
            'folke/trouble.nvim',
            requires = 'nvim-tree/nvim-web-devicons',
            config = function()
                require('plugin-config.interface.trouble')
            end,
        },

        -- Marks
        {
            'chentoast/marks.nvim',
            config = function()
                require('plugin-config.interface.marks')
            end,
        },

        ----- Color Schemes -----
        -------------------------

        { 'Mofiqul/dracula.nvim' },
        { 'EdenEast/nightfox.nvim' },

        ----- Code Appearance  -----
        ----------------------------

        -- Highlighting
        {
            'nvim-treesitter/nvim-treesitter',
            run = function()
                require('nvim-treesitter.install').update({
                    with_sync = true,
                })
            end,
            config = function()
                require('plugin-config.appearance.nvim-treesitter')
            end,
        },
        {
            'nvim-treesitter/nvim-treesitter-textobjects',
            after = 'nvim-treesitter',
            requires = 'nvim-treesitter/nvim-treesitter',
        },
        {
            'nvim-treesitter/nvim-treesitter-refactor',
            after = 'nvim-treesitter',
            requires = 'nvim-treesitter/nvim-treesitter',
        },
        {
            'fei6409/log-highlight.nvim',
            config = function()
                require('log-highlight').setup({})
            end,
        },

        -- To-do Comments.nvim
        {
            'folke/todo-comments.nvim',
            requires = { 'nvim-lua/plenary.nvim' },
            config = function()
                require('plugin-config.appearance.todo-comments')
            end,
        },

        -- Indent-blankline
        {
            'lukas-reineke/indent-blankline.nvim',
            config = function()
                require('plugin-config.appearance.indent-blankline')
            end,
        },

        -- Fold
        {
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
        },

        -- Breadcrumb Bar
        {
            'SmiteshP/nvim-navic',
            requires = 'neovim/nvim-lspconfig',
            config = function()
                require('plugin-config.appearance.navic')
            end,
        },

        -- Sticky Scroll
        {
            'nvim-treesitter/nvim-treesitter-context',
            config = function()
                require('plugin-config.appearance.nvim-treesitter-context')
            end,
        },

        -- Color code display like: #00ffff
        {
            'norcalli/nvim-colorizer.lua',
            config = function()
                require('plugin-config.appearance.colorizer')
            end,
        },

        -- gitsigns
        {
            'lewis6991/gitsigns.nvim',
            config = function()
                require('plugin-config.appearance.gitsigns')
                require('scrollbar.handlers.gitsigns').setup()
            end,
        },

        -- lspsaga
        {
            'glepnir/lspsaga.nvim',
            opt = true,
            branch = 'main',
            event = 'BufReadPost',
            config = function()
                require('lspsaga').setup({})
            end,
            requires = {
                { 'nvim-tree/nvim-web-devicons' },
                --Please make sure you install markdown and markdown_inline parser
                { 'nvim-treesitter/nvim-treesitter' },
            },
            after = 'nvim-lspconfig',
        },

        ----- Editor -----
        ------------------

        -- Comment Toggle
        {
            'numToStr/Comment.nvim',
            config = function()
                require('plugin-config.editor.comment')
            end,
        },

        -- Surround
        {
            'kylechui/nvim-surround',
            config = function()
                require('plugin-config.editor.nvim-surround')
            end,
        },

        -- nvim-autopairs
        {
            'windwp/nvim-autopairs',
            config = function()
                require('plugin-config.editor.nvim-autopairs')
            end,
        },

        -- Refactoring
        {
            'ThePrimeagen/refactoring.nvim',
            requires = {
                { 'nvim-lua/plenary.nvim' },
                { 'nvim-treesitter/nvim-treesitter' },
            },
            config = function()
                require('plugin-config.editor.refactoring')
            end,
        },

        -- winshift
        {
            'sindrets/winshift.nvim',
            config = function()
                require('plugin-config.editor.winshift')
            end,
        },

        ----- Search Tools -----
        ------------------------

        -- Telescope
        {
            'nvim-telescope/telescope.nvim',
            tag = '0.1.1',
            requires = {
                'nvim-lua/plenary.nvim',
            },
            config = function()
                require('plugin-config.search.telescope')
            end,
        },
        { 'LinArcX/telescope-env.nvim' },
        { 'LinArcX/telescope-command-palette.nvim' },
        { 'smartpde/telescope-recent-files' },
        { 'rmagatti/session-lens' },

        -- Project
        {
            'ahmedkhalf/project.nvim',
            config = function()
                require('plugin-config.search.project')
            end,
        },

        -- Leap
        {
            'ggandor/leap.nvim',
            config = function()
                require('plugin-config.search.leap')
            end,
            requires = { 'tpope/vim-repeat' },
        },

        ----- LSP -----
        ---------------

        { 'williamboman/mason.nvim' },
        { 'williamboman/mason-lspconfig.nvim' },
        {
            'jay-babu/mason-null-ls.nvim',
            requires = {
                'jose-elias-alvarez/null-ls.nvim',
                requires = 'nvim-lua/plenary.nvim',
            },
        },
        { 'neovim/nvim-lspconfig' },

        ----- Snippets -----
        --------------------

        { 'hrsh7th/cmp-nvim-lsp' },
        { 'onsails/lspkind-nvim' },
        { 'quangnguyen30192/cmp-nvim-ultisnips' },
        -- Engine
        {
            'hrsh7th/nvim-cmp',
            module = { 'cmp' },
            requires = {
                { 'hrsh7th/cmp-nvim-lsp-signature-help', event = { 'InsertEnter' } },
                { 'hrsh7th/cmp-buffer', event = { 'InsertEnter', 'CmdLineEnter *' } },
                { 'hrsh7th/cmp-path', event = { 'InsertEnter' } },
                { 'hrsh7th/cmp-cmdline', event = { 'CmdLineEnter *' } },
                { 'dmitmel/cmp-cmdline-history', event = { 'CmdLineEnter *' } },
                { 'hrsh7th/cmp-emoji', event = { 'InsertEnter' } },
                { 'SirVer/ultisnips', event = { 'InsertEnter' } },
            },
            config = function()
                require('cmp.setup')
            end,
            wants = { 'cmp-nvim-lsp', 'lspkind-nvim', 'cmp-nvim-ultisnips' },
        },

        -- My snippet
        { 'montenoki/vim-snippets' },

        ----- DAP -----
        ---------------
        { 'mfussenegger/nvim-dap' },
        {
            'rcarriga/nvim-dap-ui',
            config = function()
                require('dap.dapui')
            end,
        },
        { 'theHamsta/nvim-dap-virtual-text' },
        { 'jbyuki/one-small-step-for-vimkind' },

        ---------  Language Support -----------
        ---------------------------------------

        -- Python
        { 'mfussenegger/nvim-dap-python' },

        -- Lua
        {
            'folke/neodev.nvim',
            config = function()
                require('neodev').setup({
                    library = { plugins = { 'nvim-dap-ui' }, types = true },
                })
            end,
        },

        -- Rust
        { 'simrat39/rust-tools.nvim' },

        -- R
        { 'jalvesaq/Nvim-R' },
    })
end

if packer_bootstrap then
    require('lua.plugins').sync()
end

return setmetatable({}, {
    __index = function(_, key)
        init()
        return packer[key]
    end,
})
