local dashboard = requirePlugin('dashboard')
if dashboard == nil then
    return
end

dashboard.custom_header = {
    [[                                        ■■                                                        ]],
    [[                                       ■  ■                                                       ]],
    [[ ■■■■■         ■■                      ■  ■  ■             ■■■■        ■■■■■■■■■■■■■      ■       ]],
    [[ ■   ■■■      ■■■            ■■■■■■■■■■■■■   ■               ■■■■■■              ■■      ■■       ]],
    [[ ■    ■■      ■■■                      ■     ■                   ■■■             ■■      ■■       ]],
    [[ ■     ■■    ■■■■     ■■■■            ■■     ■                              ■■  ■■       ■        ]],
    [[ ■     ■■   ■■ ■■    ■■  ■            ■■     ■             ■■               ■  ■■       ■■        ]],
    [[ ■     ■■   ■  ■■   ■■                ■      ■        ■    ■■■■■■           ■  ■        ■■        ]],
    [[ ■     ■■  ■■  ■■   ■■               ■■      ■       ■■        ■■■■         ■           ■    ■■   ]],
    [[ ■     ■■  ■   ■■   ■                ■       ■      ■■                      ■          ■■     ■■  ]],
    [[ ■     ■■ ■■■■■■■■  ■■              ■■       ■     ■■                      ■■          ■■      ■  ]],
    [[ ■    ■■       ■■   ■■             ■■        ■   ■■■      ■■■              ■■          ■      ■■■ ]],
    [[ ■   ■■■       ■■    ■■  ■       ■■■         ■■■■■         ■■■■■■         ■■         ■■■■■■■■■■■■ ]],
    [[ ■■■■■         ■■     ■■■■     ■■■■          ■■■                ■■■      ■■         ■■■■■■      ■■]],
    [[                               ■■                                       ■■                      ■■]],
    [[                                                                                                  ]],
    [[                                      [ version : 1.0.0 ]                                         ]],
}

dashboard.custom_center = {
    { icon = '  ', desc = 'Projects         ', action = 'Telescope projects' },
    { icon = '  ', desc = 'Recently files   ', action = 'Telescope oldfiles' },
    { icon = '  ', desc = 'Edit keybindings ', action = 'edit ~/.config/nvim/lua/keybindings.lua' },
    { icon = '  ', desc = 'Edit Projects    ', action = 'edit ~/.local/share/nvim/project_nvim/project_history' },
    { icon = '  ', desc = 'Show ENV         ', action = 'Telescope env' },
    { icon = '  ', desc = 'Find file        ', action = 'Telescope find_files' },
    { icon = '  ', desc = 'Find text        ', action = 'Telescope live_grep' },
}

dashboard.custom_footer = { 'https://www.data4cs.co.jp' }
