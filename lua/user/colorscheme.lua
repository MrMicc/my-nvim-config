-- tokyonight variations
-- vim.cmd.colorscheme("tokyonight")
-- vim.cmd.colorscheme("tokyonight-night")
-- vim.cmd.colorscheme("tokyonight-storm")
vim.cmd.colorscheme("tokyonight-moon")

local green = '#69ff94'
local syellow = '#ff966c'
local bg = '#f0f0f0'

-- fix xml sintax
vim.cmd [[hi! link Function Label ]]
vim.cmd [[hi! link Identifier Function ]]
vim.cmd [[hi! link xmlTagN Function ]]

vim.api.nvim_set_hl(0, "CursorLine", { bg = 'none', blend = 95 })

vim.cmd [[
    highlight Cursor guifg=none guibg=#69ff94
    highlight iCursor guifg=none guibg=#69ff94
    set guicursor=n-v-c:block-Cursor
    set guicursor+=i:hor20-iCursor
    set guicursor+=n-v-c:blinkon0
    set guicursor+=i:blinkwait10
    hi TreesitterContextBottom gui=undercurl guisp=#69ff94
]]

-- selected winbar
vim.api.nvim_set_hl(0, 'Winbar', { fg = green, bg = 'none' })
vim.api.nvim_set_hl(0, 'WinBarNC', { fg = 'white', bg = 'none' })
vim.api.nvim_set_hl(0, 'WinBarSeparator', { fg = 'white', bg = 'none' })
vim.api.nvim_set_hl(0, 'WinSeparator', { fg = green, bold = false })
vim.api.nvim_set_hl(0, 'VertSplit', { fg = green, bold = false })
vim.api.nvim_set_hl(0, 'NvimTreeWinSeparator', { fg = green, bold = false })
vim.api.nvim_set_hl(0, 'LspInlayHint', { fg = '#636da6', bg = 'none' })
vim.api.nvim_set_hl(0, 'FloatBorder', { fg = 'white', bg = 'none' })

vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextInfo', { bg = 'none', fg = 'yellow' })
vim.api.nvim_set_hl(0, 'TreesitterContext', { bg = 'none', fg = 'yellow' })

vim.api.nvim_set_hl(0, 'NvimTreeIndentMarker', { bg = 'none', fg = green })

vim.api.nvim_set_hl(0, 'Search', { fg = green, bg = '#291c17', underline = true })
vim.api.nvim_set_hl(0, 'IncSearch', { fg = syellow, bg = '#291c17', underline = true })


-- vim.api.nvim_set_hl(0, 'FloatShadow', { fg = '#636da6', bg = 'none' })
-- vim.api.nvim_set_hl(0, 'FloatShadowThrough', { fg = '#636da6', bg = 'none' })

-- vim.cmd [[hi NoiceVirtualText guibg=NONE ]]
