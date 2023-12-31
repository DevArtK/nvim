return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },

    config = function()
        local mason = require("mason")
        local mason_lspconfig = require("mason-lspconfig")
        local mason_tool_installer = require("mason-tool-installer")
        mason.setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
                border = "double",
                width = 0.8,
                height = 0.8,
            },
        })

        -- mason-lspconfig
        mason_lspconfig.setup({
            ensure_installed = {
                "lua_ls",
                "cssls",
                "marksman",
                'angularls',
                'ansiblels',
                'terraformls'
            },
            -- auto installation
            automatic_installation = true,
        })

        -- mason-tool-installer
        mason_tool_installer.setup({
            ensure_installed = {
                --{ "angularls" },
                { 'angular-language-server' },
                -- { "ansiblels" },
                { 'ansible-language-server' },
                { "autopep8" },
                { "awkls" },
                { 'bash-language-server' },
                { 'black' },
                { 'codelldb' },
                { 'css-lsp' },
                { 'dockerls' },
                { 'docker_compose_language_service' },
                { 'editorconfig-checker' },
                { 'emmet-ls' },
                { 'eslint-lsp' },
                { 'eslint_d' },
                { 'groovyls' },
                { 'hls' },
                { 'html-lsp' },
                { 'js-debug-adapter' },
                { 'json-lsp' },
                { 'lua-language-server' },
                { 'node-debug2-adapter' },
                { 'prettier' },
                { 'pyright' },
                { 'rust_analyzer' },
                { 'stylua' },
                { 'tailwindcss-language-server' },
                { 'terraformls' },
                { 'typescript-language-server' },
                { 'vim-language-server' },
                { 'yamlls' }
            },

            auto_update = true,
            run_on_start = true,
            start_delay = 3000, -- 3 second delay
            debounce_hours = 5, -- at least 5 hours between attempts to install/update
        })
    end,
}
