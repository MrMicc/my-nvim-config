local gpg = require("user.utils.gpg")

return {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    opts = {
        provider = "gemini",
        providers = {
            gemini = {
                parse_api_key = gpg.decrypt_gemini_key,
                model = "gemini-2.0-flash",
                timeout = 300000, -- 5 minutes timeout for long tasks
                extra_request_body = {
                    temperature = 0.7
                },
            },
            ollama = {
                endpoint = "http://192.168.1.59:11434",
                -- model = "qwen3:30b-a3b",
                -- model = "deepseek-r1:14b",
                model = "qwen3:8b",
                -- model = "codestral:22b",
            },
            openai = {
                model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
                parse_api_key = gpg.decrypt_openai_key,
                endpoint = "https://api.openai.com/v1",
                timeout = 30000,
                extra_request_body = {
                    temperature = 0.1,
                    max_completion_tokens = 16384,
                    stream = true
                },
            },
            claude = {
                endoint = "https://api.anthropic.com",
                model = "claude-sonnet-4-20250514",
                parse_api_key = gpg.decrypt_claude_key,
                timeout = 30000, -- Timeout in milliseconds
                extra_request_body = {
                    temperature = 0.75,
                    max_tokens = 20480,
                },
            }
            -- openrouter = {
            --     __inherited_from = "openai",
            --     endpoint = "https://openrouter.ai/api/v1",
            --     parse_api_key = gpg.decrypt_openrouter_key,
            -- model = "mistralai/devstral-small:free",
            -- parse_curl_args = function(opts, code_opts) end,
            -- parse_response = function(data_stream, event_state, opts) end,
            -- parse_stream_data = function(data, handler_opts) end
            -- },
            -- grok4 = {
            --     __inherited_from = "openai",
            --     endpoint = "https://api.x.ai/v1",
            --     parse_api_key = gpg.decrypt_grok4_key,
            --     model = "grok-3-latest",
            -- parse_curl_args = function(opts, code_opts) end,
            -- parse_response = function(data_stream, event_state, opts) end,
            -- parse_stream_data = function(data, handler_opts) end
            -- },
        },
        web_search_engine = {
            provider = 'tavily',
            -- parse_api_key = gpg.decrypt_tavily_key
        },
        hints = { enabled = true },
        behaviour = {
            auto_suggestions = false, -- Experimental stage
            auto_set_highlight_group = true,
            auto_set_keymaps = true,
            auto_apply_diff_after_generation = false,
            support_paste_from_clipboard = true,
            minimize_diff = true,         -- Whether to remove unchanged lines when applying a code block
            enable_token_counting = true, -- Whether to enable token counting. Default to true.
        },
        windows = {
            ---@type "right" | "left" | "top" | "bottom"
            position = "right",   -- the position of the sidebar
            wrap = true,          -- similar to vim.o.wrap
            width = 30,           -- default % based on available width
            sidebar_header = {
                enabled = true,   -- true, false to enable/disable the header
                align = "center", -- left, center, right for title
                rounded = true,
            },
            input = {
                prefix = "> ",
                height = 8, -- Height of the input window in vertical layout
            },
            edit = {
                border = "rounded",
                start_insert = true, -- Start insert mode when opening the edit window
            },
            ask = {
                floating = false,    -- Open the 'AvanteAsk' prompt in a floating window
                start_insert = true, -- Start insert mode when opening the ask window
                border = "rounded",
                ---@type "ours" | "theirs"
                focus_on_apply = "ours", -- which diff to focus after applying
            },
        },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "stevearc/dressing.nvim",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        --- The below dependencies are optional,
        "echasnovski/mini.pick",         -- for file_selector provider mini.pick
        "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
        "hrsh7th/nvim-cmp",              -- autocompletion for avante commands and mentions
        "ibhagwan/fzf-lua",              -- for file_selector provider fzf
        "nvim-tree/nvim-web-devicons",   -- or echasnovski/mini.icons
        "zbirenbaum/copilot.lua",        -- for providers='copilot'
        {
            -- support for image pasting
            "HakonHarnes/img-clip.nvim",
            event = "VeryLazy",
            opts = {
                -- recommended settings
                default = {
                    embed_image_as_base64 = false,
                    prompt_for_file_name = false,
                    drag_and_drop = {
                        insert_mode = true,
                    },
                    -- required for Windows users
                    use_absolute_path = true,
                },
            },
        },
        {
            -- Make sure to set this up properly if you have lazy=true
            'MeanderingProgrammer/render-markdown.nvim',
            opts = {
                file_types = { "markdown", "Avante" },
            },
            ft = { "markdown", "Avante" },
        },
    },
}
