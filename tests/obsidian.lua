-- Run after loading this repository's full config; sample notes are read only.
local function check()
    local vault = vim.fn.expand("~/obsidian/test")
    vim.cmd.edit(vault .. "/Welcome.md")
    local obsidian = require("obsidian")
    assert(Obsidian and Obsidian._setup_called and not Obsidian._config_error)
    assert(Obsidian.workspace.name == "test")
    assert(tostring(Obsidian.workspace.path) == vault)
    assert(Obsidian.opts.ui.enable == false)
    assert(vim.fn.exists(":Obsidian") == 2)
    assert(
        vim.wait(5000, function()
            local clients =
                vim.lsp.get_clients({ bufnr = 0, name = "obsidian-ls" })
            return #clients == 1 and clients[1].initialized
        end, 20),
        "Obsidian LSP did not attach"
    )

    obsidian.actions.follow_link("[[Second-note]]")
    assert(
        vim.wait(5000, function()
            return vim.api.nvim_buf_get_name(0) == vault .. "/Second-note.md"
        end, 20),
        "Failed to follow the note link"
    )
    obsidian.actions.follow_link("[[Welcome]]")
    assert(
        vim.wait(5000, function()
            return vim.api.nvim_buf_get_name(0) == vault .. "/Welcome.md"
        end, 20),
        "Failed to follow the return link"
    )

    vim.cmd("checkhealth obsidian render-markdown")
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    local output = vim.env.OBSIDIAN_HEALTH_OUTPUT
        or "/tmp/nvim-obsidian-health.txt"
    vim.fn.writefile(lines, output)
    local report = table.concat(lines, "\n")
    assert(not report:find("ERROR", 1, true), "Health errors: " .. output)
    assert(report:find("configuration passed validation", 1, true))
    assert(report:find("obsidian: installed but should not conflict", 1, true))
    print(
        "PASS: Obsidian setup, LSP attach, bidirectional links, health compatibility"
    )
end

local ok, err = xpcall(check, debug.traceback)
if not ok then
    vim.fn.writefile({ err }, "/tmp/nvim-obsidian-test-error.txt")
    vim.api.nvim_err_writeln(err)
    vim.cmd("cquit 1")
end
vim.cmd("qa!")
