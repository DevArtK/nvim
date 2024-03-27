return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
        local lspconfig = require("lspconfig")
        local lspui = require("lspconfig.ui.windows")
        local cmp_nvim_lsp = require("cmp_nvim_lsp")
        local capabilities = cmp_nvim_lsp.default_capabilities()

        local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        end

        -- Auto Formatting
        vim.cmd([[autocmd BufWritePre * lua vim.lsp.buf.format()]])

        --LspInfo Borders
        lspui.default_options.border = "double"

        -- Managing language servers individually
        -- Angular
        lspconfig.angularls.setup({
            capabilities = capabilities,
        })

        -- ANSIBLE
        lspconfig.ansiblels.setup({
            capabilities = capabilities,
        })

        -- AWK
        lspconfig.awk_ls.setup({
            capabilities = capabilities,
        })

        -- BASH
        lspconfig.bashls.setup({
            capabilities = capabilities,
        })


        -- DOCKER
        lspconfig.dockerls.setup({
            capabilities = capabilities,
        })

        -- DOCKER COMPOSE
        lspconfig.docker_compose_language_service.setup({
            capabilities = capabilities,
        })

        -- HASKELL
        lspconfig.hls.setup({
            capabilities = capabilities,
        })

        -- PYTHON
        lspconfig.pyright.setup({
            capabilities = capabilities,
        })

        -- JAVASCRIPT / TYPESCRIPT
        lspconfig.tsserver.setup({
            capabilities = capabilities,
        })

        -- TERRAFORM
        lspconfig.terraformls.setup({
            cmd = { "terraform-ls", "serve" },
            filetypes = { "hcl", "tf", "tfvars" },
            capabilities = capabilities,
            root_dir = lspconfig.util.root_pattern(".terraform", ".tf", "main.tf", "providers.tf", "tf"),
            settings = {
                terraform = {
                    lsp = {
                        format = true,
                        codeLens = {
                            enabled = true,
                        },
                    },
                },
            }
        })
        
        -- TERRAFORM LINTER
        -- lspconfig.tflint.setup({
        --     capabilities = capabilities,
        --     lspconfig.util.root_pattern(".terraform", ".git", ".tflint.hcl", '.tf')
        -- })

        -- RUST_ANALYZER
        lspconfig.rust_analyzer.setup({
            capabilities = capabilities,
            -- Server-specific settings. See `:help lspconfig-setup`
            settings = {
                ["rust-analyzer"] = {},
            },
        })

        -- HTML
        lspconfig.html.setup({
            capabilities = capabilities,
        })
        -- configure emmet language server
        lspconfig.emmet_ls.setup({
            capabilities = capabilities,
            filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
        })

        -- LUA LS
        lspconfig.lua_ls.setup({
            capabilities = capabilities,
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" },
                    },
                },
            },
        })

        -- CSS LS
        lspconfig.cssls.setup({
            capabilities = capabilities,
        })

        -- TAILWIND
        -- Support for tailwind auto completion
        -- install the tailwind server : "sudo npm install -g @tailwindcss/language-server"
        lspconfig.tailwindcss.setup({
            capabilities = capabilities,
        })
    end,
}
