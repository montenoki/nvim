return {
    "blink.cmp",
    opts = {
        completion = { list = { selection = "manual" } },
        keymap = {
            preset = "enter",
            ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
            ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },

            ["<Up>"] = { "fallback" },
            ["<Down>"] = { "fallback" },
            ["<C-p>"] = { "fallback" },
            ["<C-n>"] = { "fallback" },
        },
    },
}
