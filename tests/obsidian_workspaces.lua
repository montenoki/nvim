-- Run: nvim --headless -u NONE -i NONE -l tests/obsidian_workspaces.lua
vim.opt.rtp:prepend(vim.fn.getcwd())
local discover = require("config.obsidian").workspaces
local root = vim.fn.tempname()
vim.fn.mkdir(root, "p")

local function check()
    assert(#discover(root .. "/missing") == 0)
    assert(#discover(root) == 0)
    for _, path in ipairs({
        "work/.obsidian",
        "personal/.obsidian",
        "ordinary",
        "marker-file",
        "nested/vault/.obsidian",
        ".hidden/.obsidian",
    }) do
        vim.fn.mkdir(root .. "/" .. path, "p")
    end
    vim.fn.writefile({}, root .. "/marker-file/.obsidian")
    local workspaces = discover(root)
    assert(#workspaces == 2, "Only immediate vault directories should match")
    assert(workspaces[1].name == "personal")
    assert(workspaces[2].name == "work")
    for _, ws in ipairs(workspaces) do
        assert(ws.path == root .. "/" .. ws.name and ws.strict)
    end

    local plugin_root = vim.fn.expand("~/.local/share/nvim/lazy")
    vim.opt.rtp:append(plugin_root .. "/obsidian.nvim")
    vim.opt.rtp:append(plugin_root .. "/telescope.nvim")
    vim.opt.rtp:append(plugin_root .. "/plenary.nvim")
    local opts = dofile("lua/plugins/obsidian.lua").opts
    opts.workspaces = workspaces
    require("obsidian").setup(opts)
    vim.cmd.runtime("plugin/obsidian.lua")
    assert(Obsidian and not Obsidian._config_error)
    local api = require("obsidian.api")
    for _, name in ipairs({ "personal", "work" }) do
        local ws = api.find_workspace(root .. "/" .. name .. "/new-note.md")
        assert(ws and ws.name == name, "Wrong workspace for note path")
        vim.cmd("Obsidian workspace " .. name)
        assert(Obsidian.workspace.name == name)
        assert(tostring(Obsidian.dir) == root .. "/" .. name)
    end
    assert(api.find_workspace(root .. "/ordinary/note.md") == nil)

    vim.fn.mkdir(root .. "/new-vault/.obsidian", "p")
    assert(#discover(root) == 3, "Next scan should discover the new vault")
    print(
        "PASS: workspace discovery, filtering, ordering and multi-vault switching"
    )
end

local ok, err = xpcall(check, debug.traceback)
vim.fn.delete(root, "rf")
if not ok then
    error(err)
end
