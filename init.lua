-- bootstrap lazy.nvim, LazyVim and your plugins
local platform = require("config.platform")
if platform.nix_managed_config then
    -- These optional remote providers are unused. Node itself remains available
    -- for plugins that invoke it as an external runtime.
    vim.g.loaded_node_provider = 0
    vim.g.loaded_perl_provider = 0
    vim.g.loaded_ruby_provider = 0
end

-- Match the filetype expected by the Docker Compose language server.
vim.filetype.add({
    filename = {
        ["docker-compose.yml"] = "yaml.docker-compose",
        ["docker-compose.yaml"] = "yaml.docker-compose",
        ["compose.yml"] = "yaml.docker-compose",
        ["compose.yaml"] = "yaml.docker-compose",
    },
})

require("config.lazy")
