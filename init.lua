-- bootstrap lazy.nvim, LazyVim and your plugins
local platform = require("config.platform")
if platform.nix_managed_config then
    -- These optional remote providers are unused. Node itself remains available
    -- for plugins that invoke it as an external runtime.
    vim.g.loaded_node_provider = 0
    vim.g.loaded_perl_provider = 0
    vim.g.loaded_ruby_provider = 0
end

require("config.lazy")
