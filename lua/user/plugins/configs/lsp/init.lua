-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
--
-- lsp settings:
utils.init_err_handler('ansiblels', function() require "user.plugins.configs.lsp.ansiblels" end)
utils.init_err_handler('cssls', function() require "user.plugins.configs.lsp.cssls" end)
utils.init_err_handler('dartls', function() require "user.plugins.configs.lsp.dartls" end)
utils.init_err_handler('docker', function() require "user.plugins.configs.lsp.docker" end)
utils.init_err_handler('eslint', function() require "user.plugins.configs.lsp.eslint" end)
utils.init_err_handler('gopls', function() require "user.plugins.configs.lsp.gopls" end)
utils.init_err_handler('html', function() require "user.plugins.configs.lsp.html" end)
utils.init_err_handler('jdtls', function() require "user.plugins.configs.lsp.jdtls" end)
utils.init_err_handler('jsonls', function() require "user.plugins.configs.lsp.jsonls" end)
utils.init_err_handler('groovyls', function() require "user.plugins.configs.lsp.groovyls" end)
utils.init_err_handler('lemminx', function() require "user.plugins.configs.lsp.lemminx" end)
utils.init_err_handler('ltexls', function() require "user.plugins.configs.lsp.ltexls" end)
utils.init_err_handler('lua_ls', function() require "user.plugins.configs.lsp.lua_ls" end)
utils.init_err_handler('marksman', function() require "user.plugins.configs.lsp.marksman" end)
utils.init_err_handler('pyright', function() require "user.plugins.configs.lsp.pyright" end)
utils.init_err_handler('rust_analyzer', function() require "user.plugins.configs.lsp.rust_analyzer" end)
utils.init_err_handler('terraformls', function() require "user.plugins.configs.lsp.terraformls" end)
utils.init_err_handler('tsserver', function() require "user.plugins.configs.lsp.tsserver" end)
utils.init_err_handler('yamlls', function() require "user.plugins.configs.lsp.yamlls" end)
utils.init_err_handler('taplo', function() require "lspconfig".taplo.setup {} end)


-- diagnostic signs
vim.fn.sign_define(
    'DiagnosticSignError',
    { text = '', texthl = 'LspDiagnosticsDefaultError' }
)

vim.fn.sign_define(
    'DiagnosticSignWarn',
    { text = '', texthl = 'LspDiagnosticsDefaultWarning' }
)

vim.fn.sign_define(
    'DiagnosticSignInfo',
    { text = '', texthl = 'LspDiagnosticsDefaultInformation' }
)

vim.fn.sign_define(
    'DiagnosticSignHint',
    { text = '', texthl = 'LspDiagnosticsDefaultHint' }
)

vim.cmd('highlight link LspDiagnosticsDefaultError DiagnosticError ')
vim.cmd('highlight link LspDiagnosticsDefaultWarning DiagnosticWarn ')
vim.cmd('highlight link LspDiagnosticsDefaultInformation DiagnosticInfo ')
vim.cmd('highlight link LspDiagnosticsDefaultHint DiagnosticHint ')


vim.diagnostic.config {
    underline        = true,
    virtual_text     = false,
    signs            = true,
    update_in_insert = true,
    severity_sort    = false,
    float            = {
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
    },
}

-- vim.cmd([[ set signcolumn=yes autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false }) ]])
