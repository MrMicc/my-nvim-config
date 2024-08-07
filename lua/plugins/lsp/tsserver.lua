local on_attach_options = require("plugins.lsp.utils.on_attach_options")
local capabilities_options = require("plugins.lsp.utils.capabilities_options")
local lspconfig = require 'lspconfig'

lspconfig.tsserver.setup {
    -- format options delegated to eslint lsp
    on_attach = on_attach_options.get({
        inlay = false,
        format_on_save = true,
        rename = true,
        format = true,
        lsp_client = 'tsserver'
    }),
    init_options = {
        hostInfo = "neovim",
        preferences = {
            includeInlayParameterNameHints = 'all',
            includeInlayParameterNameHintsWhenArgumentMatchesName = true,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
            importModuleSpecifierPreference = 'non-relative',
        },
    },
    capabilities = capabilities_options.default
}
