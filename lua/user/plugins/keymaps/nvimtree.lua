
local n = require "user.keymaps._utils".n

-- Show file explorer
-- Abre painel de arquivos coc-explorer
-- n( "<space>e", ":CocCommand explorer<CR>")
n( "<space>e", ":NvimTreeToggle<CR>")
n( "<space>f", ":NvimTreeFindFile<CR>")


