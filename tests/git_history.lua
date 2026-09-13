vim.cmd("doautocmd User VeryLazy")
local dir = vim.fn.tempname()
vim.fn.mkdir(dir, "p")
local function git(...)
    local a = { "git", "-C", dir }
    vim.list_extend(a, { ... })
    local r = vim.system(a, { text = true }):wait()
    assert(r.code == 0, r.stderr)
    return vim.trim(r.stdout)
end
local file = dir .. "/old.txt"
vim.fn.writefile({ "old line", "same" }, file)
git("init", "-q")
git("add", ".")
git(
    "-c",
    "user.name=Test",
    "-c",
    "user.email=test@example.invalid",
    "commit",
    "-qm",
    "old"
)
local commit = git("rev-parse", "HEAD")
git("mv", "old.txt", "new.txt")
git(
    "-c",
    "user.name=Test",
    "-c",
    "user.email=test@example.invalid",
    "commit",
    "-qm",
    "rename"
)
file = dir .. "/new.txt"
vim.cmd.cd(dir)
vim.cmd.edit(file)
local original = vim.api.nvim_get_current_buf()
vim.api.nvim_buf_set_lines(original, 0, 1, false, { "unsaved current" })
local status = git("status", "--porcelain")
local tabs = #vim.api.nvim_list_tabpages()
for _, source in ipairs({ "git_log_file", "git_log_line" }) do
    local picker = Snacks.picker[source]({ cwd = dir })
    assert(
        vim.wait(5000, function()
            return picker.shown and picker:current()
        end, 20),
        "picker ready"
    )
    local item
    for _, i in ipairs(picker:items()) do
        if commit:find(i.commit, 1, true) == 1 then
            item = i
        end
    end
    assert(item, "old commit not found")
    require("config.git_history").compare(picker, item)
    assert(#vim.api.nvim_list_tabpages() == tabs + 1, "diff tab")
    local wins = vim.api.nvim_tabpage_list_wins(0)
    assert(#wins == 2)
    local content = {}
    for _, w in ipairs(wins) do
        local b = vim.api.nvim_win_get_buf(w)
        assert(vim.wo[w].diff)
        assert(not vim.bo[b].modifiable and vim.bo[b].readonly)
        content[vim.api.nvim_buf_get_lines(b, 0, 1, false)[1]] = true
    end
    assert(content["old line"] and content["unsaved current"], "diff contents")
    vim.cmd.tabclose()
    assert(vim.api.nvim_get_current_buf() == original)
    assert(vim.bo[original].modified)
    assert(not vim.wo.diff)
    assert(status == git("status", "--porcelain"))
    assert(vim.fn.readfile(file)[1] == "old line")
end
print(
    "PASS: gf/gb history diff, renamed file, unsaved content, read-only snapshots, original layout and worktree unchanged"
)
vim.cmd("qa!")
