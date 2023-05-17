local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local packer_bootstrap
local uConfig = require('uConfig')
local lite_mode = uConfig.lite_mode
local enable_impatient = uConfig.enable_impatient

-- Packer: Auto install
if fn.empty(fn.glob(install_path)) > 0 then
    vim.notify('Installing Packer.nvim... Please wait...')
    packer_bootstrap = fn.system({
            'git',
            'clone',
            '--depth',
            '1',
            'https://github.com/wbthomason/packer.nvim',
            install_path,
        })
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
        if enable_impatient then
            use('lewis6991/impatient.nvim')
        end

        ----- colorschemes -----
        ------------------------
        use('Mofiqul/dracula.nvim')

        ----- nvim-treesitter -----
        ---------------------------

        use({
            'nvim-treesitter/nvim-treesitter',
            run = function()
                require('nvim-treesitter.install').update({ with_sync = true })
            end,
            requires = {
                { 'nvim-treesitter/nvim-treesitter-refactor' },
                { 'nvim-treesitter/nvim-treesitter-textobjects' },
            },
            config = function()
                require('plugin-config.appearance.nvim-treesitter')
            end,
        })

        ----- LSP -----
        ---------------

        -- -- Installer
        -- use({ 'williamboman/mason.nvim' })
        -- use({ 'williamboman/mason-lspconfig.nvim' })

        -- use({ 'neovim/nvim-lspconfig' })

        -- use('mhartington/formatter.nvim')
        -- use({ 'jose-elias-alvarez/null-ls.nvim', requires = 'nvim-lua/plenary.nvim' })


        -- -- code action
        -- use({
        --     'ThePrimeagen/refactoring.nvim',
        --     requires = {
        --         { 'nvim-lua/plenary.nvim' },
        --         { 'nvim-treesitter/nvim-treesitter' },
        --     },
        -- })

        -- ------------------------- 依存 ------------------------

        -- use('nvim-lua/popup.nvim')

        -- use('tpope/vim-repeat')

        -- use('nvim-lua/plenary.nvim')

        -- use('MunifTanjim/nui.nvim')

        -- use('tami5/lspsaga.nvim')


        -- ------------------ 自動補完 ------------------
        -- -- エンジン
        -- use({
        --     'hrsh7th/nvim-cmp',
        --     requires = {
        --         'quangnguyen30192/cmp-nvim-ultisnips',
        --         config = function()
        --             require('cmp_nvim_ultisnips').setup()
        --         end,
        --         { 'nvim-treesitter/nvim-treesitter' },
        --         { 'onsails/lspkind-nvim' },
        --     },
        -- })

        -- use('SirVer/ultisnips')

        -- -- ソース
        -- use('hrsh7th/cmp-nvim-lsp')
        -- use('hrsh7th/cmp-buffer')
        -- use('hrsh7th/cmp-path')
        -- use('hrsh7th/cmp-cmdline')
        -- use('hrsh7th/cmp-nvim-lsp-signature-help')

        -- -- 自分のsnippet
        -- use('montenoki/vim-snippets')

        -- --------------------- DAP --------------------
        -- use('mfussenegger/nvim-dap')
        -- use('theHamsta/nvim-dap-virtual-text')
        -- use('rcarriga/nvim-dap-ui')

        -- -- Lua
        -- use({ 'jbyuki/one-small-step-for-vimkind' })

        -- --------------------- CODE表示 ----------------------



        -- -- 代码折叠
        -- use({
        --     'kevinhwang91/nvim-ufo',
        --     requires = {
        --         'kevinhwang91/promise-async',
        --         {
        --             'luukvbaal/statuscol.nvim',
        --             config = function()
        --                 require('statuscol').setup({ foldfunc = 'builtin', setopt = true })
        --             end,
        --         },
        --     },
        --     config = function()
        --         require('plugin-config.appearance.ufo')
        --     end,
        -- })

        -- -- todo-comments.nvim
        -- use({
        --     'folke/todo-comments.nvim',
        --     requires = {
        --         'nvim-lua/plenary.nvim',
        --     },
        --     config = function()
        --         require('plugin-config.appearance.todo-comments')
        --     end,
        -- })

        -- -- git
        -- use({
        --     'lewis6991/gitsigns.nvim',
        --     config = function()
        --         require('plugin-config.appearance.gitsigns')
        --         require('scrollbar.handlers.gitsigns').setup()
        --     end,
        -- })

        -- -- Sticky Scroll
        -- use({
        --     'nvim-treesitter/nvim-treesitter-context',
        --     config = function()
        --         require('plugin-config.appearance.nvim-treesitter-context')
        --     end,
        -- })

        -- -- Color code display like: #ff0149
        -- use({
        --     'norcalli/nvim-colorizer.lua',
        --     config = function()
        --         require('plugin-config.appearance.colorizer')
        --     end,
        -- })

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

        -- -- -- cool movement
        -- -- use({
        -- --     'edluffy/specs.nvim',
        -- --     config = function()
        -- --         require('plugin-config.appearance.specs')
        -- --     end,
        -- -- })

        -- ---------------------- interface -----------------------
        -- -- 開始画面
        -- use({
        --     'glepnir/dashboard-nvim',
        --     config = function()
        --         require('plugin-config.interface.dashboard')
        --     end,
        -- })

        -- -- File Explorer
        -- use({
        --     'nvim-tree/nvim-tree.lua',
        --     requires = 'nvim-tree/nvim-web-devicons',
        --     config = function()
        --         require('plugin-config.interface.nvim-tree')
        --     end,
        --     tag = 'nightly',
        -- })

        -- -- タブ表示
        -- use({
        --     'akinsho/bufferline.nvim',
        --     requires = { 'kyazdani42/nvim-web-devicons', 'moll/vim-bbye' },
        --     config = function()
        --         require('plugin-config.interface.bufferline')
        --     end,
        -- })

        -- -- Notice表示
        -- use({
        --     'rcarriga/nvim-notify',
        --     config = function()
        --         require('plugin-config.interface.nvim-notify')
        --     end,
        -- })

        -- -- ステータスバー表示
        -- use({
        --     'nvim-lualine/lualine.nvim',
        --     requires = { 'kyazdani42/nvim-web-devicons', 'arkav/lualine-lsp-progress' },
        --     config = function()
        --         require('plugin-config.interface.lualine')
        --     end,
        -- })

        -- -- Terminal表示
        -- use({
        --     'akinsho/toggleterm.nvim',
        --     config = function()
        --         require('plugin-config.interface.toggleterm')
        --     end,
        -- })

        -- -- status表示
        -- use({
        --     'j-hui/fidget.nvim',
        --     config = function()
        --         require('plugin-config.interface.fidget')
        --     end,
        -- })

        -- -- zen-mode全画面
        -- use({
        --     'folke/zen-mode.nvim',
        --     config = function()
        --         require('plugin-config.interface.zen-mode')
        --     end,
        -- })

        -- -- Scroll Bar
        -- use({
        --     'petertriho/nvim-scrollbar',
        --     config = function()
        --         require('plugin-config.interface.scrollbar')
        --     end,
        -- })

        -- -- Diagnostics 表示
        -- use({
        --     'folke/trouble.nvim',
        --     requires = 'nvim-tree/nvim-web-devicons',
        --     config = function()
        --         require('plugin-config.interface.trouble')
        --     end,
        -- })

        -- -- Which-key
        -- use({
        --     'folke/which-key.nvim',
        --     config = function()
        --         vim.o.timeout = true
        --         vim.o.timeoutlen = 300
        --         require('plugin-config.whichkey')
        --     end,
        -- })

        -- ---------------------- 検索機能 -----------------------
        -- -- telescope ファイル検索
        -- use({
        --     'nvim-telescope/telescope.nvim',
        --     requires = {
        --         'nvim-lua/plenary.nvim',
        --         'LinArcX/telescope-env.nvim',
        --         'nvim-telescope/telescope-ui-select.nvim',
        --     },
        --     config = function()
        --         require('plugin-config.search.telescope')
        --     end,
        -- })

        -- -- project
        -- use({
        --     'ahmedkhalf/project.nvim',
        --     config = function()
        --         require('plugin-config.search.project')
        --     end,
        -- })

        -- ---------------------- 編集機能 -----------------------
        -- -- Comment Toggle
        -- use({
        --     'numToStr/Comment.nvim',
        --     config = function()
        --         require('plugin-config.editor.comment')
        --     end,
        -- })

        -- -- Indent-blankline
        -- use({
        --     'lukas-reineke/indent-blankline.nvim',
        --     config = function()
        --         require('plugin-config.editor.indent-blankline')
        --     end,
        -- })

        -- -- surround
        -- use({
        --     'kylechui/nvim-surround',
        --     config = function()
        --         require('plugin-config.editor.nvim-surround')
        --     end,
        -- })

        -- -- nvim-autopairs
        -- use({
        --     'windwp/nvim-autopairs',
        --     config = function()
        --         require('plugin-config.editor.nvim-autopairs')
        --     end,
        -- })

        -- --------------- Lang ----------------
        -- -- Lua
        -- use('folke/neodev.nvim')

        -- -- Python
        -- use({
        --     'mfussenegger/nvim-dap-python',
        --     -- config = function()
        --     --     require('dap-python').setup()
        --     -- end,
        -- })

        -- -- JSON
        -- use('b0o/schemastore.nvim')

        -- -- Rust
        -- use('simrat39/rust-tools.nvim')

        --------------- END ----------------
        if packer_bootstrap then
            packer.sync()
        end
    end,
    config = {
        max_jobs = 10,
        display = {
            open_fn = function()
                return require('packer.util').float({ border = 'single' })
            end,
        },
    },
})
