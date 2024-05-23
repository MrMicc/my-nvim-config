local lspconfig = require 'lspconfig'
local on_attach_options = require("user.plugins.configs.lsp.utils.on_attach_options")
local capabilities_options = require("user.plugins.configs.lsp.utils.capabilities_options")

local on_attach_eslint = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = true

    vim.cmd [[
        nnoremap <D-o> <cmd>TSToolsAddMissingImports<CR>
    ]]


    -- default on_attach
    on_attach_options.get { format_on_save = true, format = true, lsp_client = 'eslint' } (client, bufnr)
end


lspconfig.eslint.setup {
    on_attach = on_attach_eslint,
    flags = { debounce_text_changes = 500 },
    capabilities = capabilities_options.default,
    -- root_dir = function() return vim.loop.cwd() end,
    -- cmd = { 'eslint_d', '--stdio' },
    settings = {
        codeActionOnSave = {
            enable = true,
            mode = "all",
        },
        autoFixOnSave = true,
        codeAction = {
            disableRuleComment = {
                enable = true,
                location = "separateLine"
            },
            showDocumentation = {
                enable = true
            }
        },
        experimental = {
            useFlatConfig = false
        },
        format = true,
        nodePath = "",
        onIgnoredFiles = "off",
        packageManager = "npm",
        problems = {
            shortenToSingleLine = false
        },
        quiet = false,
        rulesCustomizations = {},
        run = "onType",
        useESLintClass = false,
        validate = "on",
        workingDirectory = {
            mode = "location"
        }
    }
}
