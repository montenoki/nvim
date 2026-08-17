-- bootstrap lazy.nvim, LazyVim and your plugins
local platform = require("config.platform")
if platform.nix_managed_config then
    local parser_rtp = vim.env.NVIM_NIX_PARSER_RTP
    if parser_rtp and parser_rtp ~= "" then
        vim.opt.runtimepath:append(parser_rtp)
    end

    -- These optional remote providers are unused. Node itself remains available
    -- for plugins that invoke it as an external runtime.
    vim.g.loaded_node_provider = 0
    vim.g.loaded_perl_provider = 0
    vim.g.loaded_ruby_provider = 0
end

require("config.lazy")
