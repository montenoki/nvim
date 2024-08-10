return {
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        bashls = {
          bashIde = {
            globPattern = '**/*@(.sh|.inc|.bash|.command|.zsh|zshrc|zsh_*)',
          },
        },
      },
    },
  },
}
