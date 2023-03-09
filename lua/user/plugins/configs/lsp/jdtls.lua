local jdtls = require 'jdtls'

-- mason installations registry
local mason_registry = require("mason-registry");

-- mason utils to get installation path
local get_package_install_path = function(package_name)
    return mason_registry.get_package(package_name):get_install_path()
end

-- home dir
local home = os.getenv "HOME"

-- maybe needs to improve marks because multimodule projects (maven/gradle)
local root_markers = { 'gradlew', 'mvnw', '.git', 'settings.gradle', 'pom.xml', ".lsp_root" }

-- root dir, workspace and project name
local root_dir = function() require('jdtls.setup').find_root(root_markers) end

-- project name is assumed by the folder name
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

-- eclipse needs to create workspace settings folder, you can reset it using :JdtWipeDataAndRestart
local workspace_folder = function() return vim.fn.stdpath "data" .. "/site/java/workspace-root/" .. project_name end

-- lombok jar path
local lombok_jar = vim.fn.glob(home .. '/.config/nvim/jdtls/lombok-*.jar')

-- jdtls path
local jdtls_path = get_package_install_path('jdtls')

-- on_attach custom for nvim-jdtls
local on_attach_jdtls = function(_client, buf_nr)
    -- call default on_attach
    require("user.plugins.configs.lsp.utils.on_attach_options").get{ lsp_client = 'jdtls'}(_client, buf_nr)

    local buf_opts = { noremap = true, silent = false, buffer = buf_nr }
    vim.keymap.set('n', 'df', jdtls.test_class, buf_opts)
    vim.keymap.set('n', 'dn', jdtls.test_nearest_method, buf_opts)

    -- setup dap
    jdtls.setup_dap({ hotcodereplace = 'auto' })
end

-- create bundles table
local get_bundles = function()
    -- java-debug-adapter loc
    local JAVA_DEBUG_ADAPTER_LOC = get_package_install_path('java-debug-adapter') .. "/extension/server"

    -- java-test loc
    local VSCODE_JAVA_TEST_LOC = get_package_install_path('java-test') .. "/extension/server"

    -- Debugging bundles
    local bundles = {}

    vim.list_extend(bundles, vim.split(vim.fn.glob(JAVA_DEBUG_ADAPTER_LOC .. "/*.jar"), "\n"))
    vim.list_extend(bundles, vim.split(vim.fn.glob(VSCODE_JAVA_TEST_LOC .. "/*.jar"), "\n"))

    return bundles
end

-- resolve os string to determine the jdtls plugin jar launcher
local function get_os_string()
    local os
    if vim.fn.has "macunix" then
        os = "mac"
    elseif vim.fn.has "win32" then
        os = "win"
    else
        os = "linux"
    end
    return os
end

-- Here you can configure eclipse.jdt.ls specific settings
-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
-- for a list of options
local function get_settings()
    return {
        signature_help = { enabled = true },
        java = {
            trace = { server = false },
            -- Specify any completion options
            completion = {
                favoriteStaticMembers = {
                    "org.hamcrest.MatcherAssert.assertThat",
                    "org.hamcrest.Matchers.*",
                    "org.hamcrest.CoreMatchers.*",
                    "org.junit.jupiter.api.Assertions.*",
                    "java.util.Objects.requireNonNull",
                    "java.util.Objects.requireNonNullElse",
                    "org.assertj.core.api.Assertions.*",
                    "org.mockito.Mockito.*"
                },
                filteredTypes = {
                    "com.sun.*",
                    "io.micrometer.shaded.*",
                    "java.awt.*",
                    "jdk.*", "sun.*",
                },
            },
            format = {
                settings = {
                    -- make sure to download the file from https://github.com/google/styleguide/blob/gh-pages/eclipse-java-google-style.xml
                    url = home .. "/.config/nvim/jdtls/eclipse-java-google-style.xml",
                    profile = "GoogleStyle",
                },
            },
            signatureHelp = { enabled = true },
            contentProvider = { preferred = 'fernflower' }, -- Use fernflower to decompile library code
            -- Specify any options for organizing imports
            sources = {
                organizeImports = {
                    starThreshold = 9999,
                    staticStarThreshold = 9999,
                },
            },
            configuration = {
                updateBuildConfiguration = "interactive",
                implementationsCodeLens = {
                    enabled = true
                },
                eclipse = {
                    downloadSources = true
                },
                maven = {
                    downloadSources = true
                },
                referencesCodeLens = {
                    enabled = true
                },
                references = {
                    includeDecompiledSources = true
                },
                format = {
                    enabled = true
                },
                runtimes = {
                    {
                        name = "JavaSE-1.8",
                        path = home .. "/.asdf/installs/java/corretto-8.342.07.1"
                    },
                    {
                        name = "JavaSE-11",
                        path = home .. "/.asdf/installs/java/corretto-11.0.16.9.1",
                    },
                    {
                        name = "JavaSE-14",
                        path = home .. "/.asdf/installs/java/zulu-14.29.23",
                    },
                    {
                        name = "JavaSE-17",
                        path = home .. "/.asdf/installs/java/corretto-17.0.4.9.1",
                        default = true,
                    },
                    {
                        name = "JavaSE-19",
                        path = home .. "/.asdf/installs/java/openjdk-19.0.2",
                    },
                }
            }
        }
    }
end

-- The command that starts the language server
-- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
local function get_cmd()
    return {
        home .. '/.asdf/installs/java/corretto-17.0.4.9.1/bin/java', -- jdk used for LSP Server
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xms2g',
        '-javaagent:' .. lombok_jar,
        '--add-modules=ALL-SYSTEM',
        '--add-opens',
        'java.base/java.util=ALL-UNNAMED',
        '--add-opens',
        'java.base/java.lang=ALL-UNNAMED',
        '-jar', vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
        '-configuration', jdtls_path .. "/config_" .. get_os_string(),
        '-data', workspace_folder(),
    }
end

-- jdtls attach function
local function jdtls_start_or_attach()
    local config = {
        capabilities = require('user.plugins.configs.lsp.utils.capabilities_options').default,
        flags = {
            debounce_text_changes = 80,
        },
        codeGeneration = {
            toString = {
                template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
            },
            hashCodeEquals = {
                useJava7Objects = true,
            },
            useBlocks = true,
        },
        cmd = get_cmd(),
        settings = get_settings(),
        root_dir = root_dir(),
        init_options = {
            bundles = get_bundles()
        },
        on_attach = on_attach_jdtls,
    }
    jdtls.start_or_attach(config)
end

vim.api.nvim_create_autocmd("Filetype", {
    pattern = "java", -- autocmd to start jdtls in java files
    callback = jdtls_start_or_attach
})