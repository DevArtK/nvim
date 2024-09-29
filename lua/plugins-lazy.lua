-- [[ configure and install plugins ]]
--
--
--  to check the current status of your plugins, run
--    :lazy
--
--  you can press `?` in this menu for help. use `:q` to close the window
--
--  to update plugins you can run
--    :lazy update
--
-- note: here is where you install your plugins.
require('lazy').setup({
    -- note: plugins can be added with a link (or for a github repo: 'owner/repo' link).
    'tpope/vim-sleuth', -- detect tabstop and shiftwidth automatically

    -- note: plugins can also be added by using a table,
    -- with the first argument being the link and the following
    -- keys can be used to configure plugin behavior/loading/etc.
    --
    -- use `opts = {}` to force a plugin to be loaded.


    -- note: plugins can also be configured to run lua code when they are loaded.
    --
    -- this is often very useful to both group configuration, as well as handle
    -- lazy loading plugins that don't need to be loaded immediately at startup.
    --
    -- for example, in the following configuration, we use:
    --  event = 'vimenter'
    --
    -- which loads which-key before all the ui elements are loaded. events can be
    -- normal autocommands events (`:help autocmd-events`).
    --
    -- then, because we use the `config` key, the configuration only runs
    -- after the plugin has been loaded:
    --  config = function() ... end



    -- lsp plugins
    {
        -- `lazydev` configures lua lsp for your neovim config, runtime and plugins
        -- used for completion, annotations and signatures of neovim apis
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
            library = {
                -- load luvit types when the `vim.uv` word is found
                { path = 'luvit-meta/library', words = { 'vim%.uv' } },
            },
        },
    },

    { 'bilal2453/luvit-meta',     lazy = true },

    {
        -- main lsp configuration
        'neovim/nvim-lspconfig',
        dependencies = {
            -- automatically install lsps and related tools to stdpath for neovim
            { 'williamboman/mason.nvim', config = true }, -- note: must be loaded before dependants
            'williamboman/mason-lspconfig.nvim',
            'whoissethdaniel/mason-tool-installer.nvim',

            -- useful status updates for lsp.
            -- note: `opts = {}` is the same as calling `require('fidget').setup({})`
            { 'j-hui/fidget.nvim',       opts = {} },

            -- allows extra capabilities provided by nvim-cmp
            'hrsh7th/cmp-nvim-lsp',
        },
        config = function()
            -- brief aside: **what is lsp?**
            --
            -- lsp is an initialism you've probably heard, but might not understand what it is.
            --
            -- lsp stands for language server protocol. it's a protocol that helps editors
            -- and language tooling communicate in a standardized fashion.
            --
            -- in general, you have a "server" which is some tool built to understand a particular
            -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). these language servers
            -- (sometimes called lsp servers, but that's kind of like atm machine) are standalone
            -- processes that communicate with some "client" - in this case, neovim!
            --
            -- lsp provides neovim with features like:
            --  - go to definition
            --  - find references
            --  - autocompletion
            --  - symbol search
            --  - and more!
            --
            -- thus, language servers are external tools that must be installed separately from
            -- neovim. this is where `mason` and related plugins come into play.
            --
            -- if you're wondering about lsp vs treesitter, you can check out the wonderfully
            -- and elegantly composed help section, `:help lsp-vs-treesitter`

            --  this function gets run when an lsp attaches to a particular buffer.
            --    that is to say, every time a new file is opened that is associated with
            --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
            --    function will be executed to configure the current buffer
            vim.api.nvim_create_autocmd('lspattach', {
                group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
                callback = function(event)
                    -- note: remember that lua is a real programming language, and as such it is possible
                    -- to define small helper and utility functions so you don't have to repeat yourself.
                    --
                    -- in this case, we create a function that lets us more easily define mappings specific
                    -- for lsp related items. it sets the mode, buffer and description for us each time.
                    local map = function(keys, func, desc, mode)
                        mode = mode or 'n'
                        vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'lsp: ' .. desc })
                    end

                    -- jump to the definition of the word under your cursor.
                    --  this is where a variable was first declared, or where a function is defined, etc.
                    --  to jump back, press <c-t>.
                    map('gd', require('telescope.builtin').lsp_definitions, '[g]oto [d]efinition')

                    -- find references for the word under your cursor.
                    map('gr', require('telescope.builtin').lsp_references, '[g]oto [r]eferences')

                    -- jump to the implementation of the word under your cursor.
                    --  useful when your language has ways of declaring types without an actual implementation.
                    map('gi', require('telescope.builtin').lsp_implementations, '[g]oto [i]mplementation')

                    -- jump to the type of the word under your cursor.
                    --  useful when you're not sure what type a variable is and you want to see
                    --  the definition of its *type*, not where it was *defined*.
                    map('<leader>d', require('telescope.builtin').lsp_type_definitions, 'type [d]efinition')

                    -- fuzzy find all the symbols in your current document.
                    --  symbols are things like variables, functions, types, etc.
                    map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[d]ocument [s]ymbols')

                    -- fuzzy find all the symbols in your current workspace.
                    --  similar to document symbols, except searches over your entire project.
                    map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[w]orkspace [s]ymbols')

                    -- rename the variable under your cursor.
                    --  most language servers support renaming across files, etc.
                    map('<leader>rn', vim.lsp.buf.rename, '[r]e[n]ame')

                    -- execute a code action, usually your cursor needs to be on top of an error
                    -- or a suggestion from your lsp for this to activate.
                    map('<leader>ca', vim.lsp.buf.code_action, '[c]ode [a]ction', { 'n', 'x' })

                    -- warn: this is not goto definition, this is goto declaration.
                    --  for example, in c this would take you to the header.
                    map('gd', vim.lsp.buf.declaration, '[g]oto [d]eclaration')

                    -- the following two autocommands are used to highlight references of the
                    -- word under your cursor when your cursor rests there for a little while.
                    --    see `:help cursorhold` for information about when this is executed
                    --
                    -- when you move your cursor, the highlights will be cleared (the second autocommand).
                    local client = vim.lsp.get_client_by_id(event.data.client_id)
                    if client and client.supports_method(vim.lsp.protocol.methods.textdocument_documenthighlight) then
                        local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight',
                            { clear = false })
                        vim.api.nvim_create_autocmd({ 'cursorhold', 'cursorholdi' }, {
                            buffer = event.buf,
                            group = highlight_augroup,
                            callback = vim.lsp.buf.document_highlight,
                        })

                        vim.api.nvim_create_autocmd({ 'cursormoved', 'cursormovedi' }, {
                            buffer = event.buf,
                            group = highlight_augroup,
                            callback = vim.lsp.buf.clear_references,
                        })

                        vim.api.nvim_create_autocmd('lspdetach', {
                            group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
                            callback = function(event2)
                                vim.lsp.buf.clear_references()
                                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
                            end,
                        })
                    end

                    -- the following code creates a keymap to toggle inlay hints in your
                    -- code, if the language server you are using supports them
                    --
                    -- this may be unwanted, since they displace some of your code
                    if client and client.supports_method(vim.lsp.protocol.methods.textdocument_inlayhint) then
                        map('<leader>th', function()
                            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
                        end, '[t]oggle inlay [h]ints')
                    end
                end,
            })

            -- lsp servers and clients are able to communicate to each other what features they support.
            --  by default, neovim doesn't support everything that is in the lsp specification.
            --  when you add nvim-cmp, luasnip, etc. neovim now has *more* capabilities.
            --  so, we create new capabilities with nvim cmp, and then broadcast that to the servers.
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

            -- enable the following language servers
            --  feel free to add/remove any lsps that you want here. they will automatically be installed.
            --
            --  add any additional override configuration in the following tables. available keys are:
            --  - cmd (table): override the default command used to start the server
            --  - filetypes (table): override the default list of associated filetypes for the server
            --  - capabilities (table): override fields in capabilities. can be used to disable certain lsp features.
            --  - settings (table): override the default settings passed when initializing the server.
            --        for example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
            local servers = {
                -- clangd = {},
                -- gopls = {},
                -- pyright = {},
                rust_analyzer = {},
                -- ... etc. see `:help lspconfig-all` for a list of all the pre-configured lsps
                --
                -- some languages (like typescript) have entire language plugins that can be useful:
                --    https://github.com/pmizio/typescript-tools.nvim
                --
                -- but for many setups, the lsp (`ts_ls`) will work just fine
                ts_ls = {},
                --

                lua_ls = {
                    -- cmd = {...},
                    -- filetypes = { ...},
                    -- capabilities = {},
                    settings = {
                        lua = {
                            completion = {
                                callsnippet = 'replace',
                            },
                            -- you can toggle below to ignore lua_ls's noisy `missing-fields` warnings
                            -- diagnostics = { disable = { 'missing-fields' } },
                        },
                    },
                },
            }

            -- ensure the servers and tools above are installed
            --  to check the current status of installed tools and/or manually install
            --  other tools, you can run
            --    :mason
            --
            --  you can press `g?` for help in this menu.
            require('mason').setup()

            -- you can add other tools here that you want mason to install
            -- for you, so that they are available from within neovim.
            local ensure_installed = vim.tbl_keys(servers or {})
            vim.list_extend(ensure_installed, {
                'stylua', -- used to format lua code
            })
            require('mason-tool-installer').setup { ensure_installed = ensure_installed }

            require('mason-lspconfig').setup {
                handlers = {
                    function(server_name)
                        local server = servers[server_name] or {}
                        -- this handles overriding only values explicitly passed
                        -- by the server configuration above. useful when disabling
                        -- certain features of an lsp (for example, turning off formatting for ts_ls)
                        server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
                        require('lspconfig')[server_name].setup(server)
                    end,
                },
            }
        end,
    },

    -- { -- you can easily change to a different colorscheme.
    --     -- change the name of the colorscheme plugin below, and then
    --     -- change the command in the config to whatever the name of that colorscheme is.
    --     --
    --     -- if you want to see what colorschemes are already installed, you can use `:telescope colorscheme`.
    --     'folke/tokyonight.nvim',
    --     priority = 1000, -- make sure to load this before all the other start plugins.
    --     init = function()
    --         -- load the colorscheme here.
    --         -- like many other themes, this one has different styles, and you could load
    --         -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
    --         vim.cmd.colorscheme 'tokyonight-night'
    --
    --         -- you can configure highlights by doing something like:
    --         vim.cmd.hi 'comment gui=none'
    --     end,
    -- },

    { -- you can easily change to a different colorscheme.
        -- change the name of the colorscheme plugin below, and then
        -- change the command in the config to whatever the name of that colorscheme is.
        --
        -- if you want to see what colorschemes are already installed, you can use `:telescope colorscheme`.
        'rebelot/kanagawa.nvim',
        priority = 1000, -- make sure to load this before all the other start plugins.
        init = function()
            -- load the colorscheme here.
            -- like many other themes, this one has different styles, and you could load
            -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
            vim.cmd.colorscheme 'kanagawa-dragon'

            -- you can configure highlights by doing something like:
            vim.cmd.hi 'comment gui=none'
        end,
    },
    -- highlight todo, notes, etc in comments

    { -- collection of various small independent plugins/modules
        'echasnovski/mini.nvim',
        config = function()
            -- better around/inside textobjects
            --
            -- examples:
            --  - va)  - [v]isually select [a]round [)]paren
            --  - yinq - [y]ank [i]nside [n]ext [q]uote
            --  - ci'  - [c]hange [i]nside [']quote
            require('mini.ai').setup { n_lines = 500 }

            -- add/delete/replace surroundings (brackets, quotes, etc.)
            --
            -- - saiw) - [s]urround [a]dd [i]nner [w]ord [)]paren
            -- - sd'   - [s]urround [d]elete [']quotes
            -- - sr)'  - [s]urround [r]eplace [)] [']
            require('mini.surround').setup()

            -- simple and easy statusline.
            --  you could remove this setup call if you don't like it,
            --  and try some other statusline plugin
            local statusline = require 'mini.statusline'
            -- set use_icons to true if you have a nerd font
            statusline.setup { use_icons = vim.g.have_nerd_font }

            -- you can configure sections in the statusline by overriding their
            -- default behavior. for example, here we set the section for
            -- cursor location to line:column
            ---@diagnostic disable-next-line: duplicate-set-field
            statusline.section_location = function()
                return '%2l:%-2v'
            end

            -- ... and there is more!
            --  check out: https://github.com/echasnovski/mini.nvim
        end,
    },

    -- the following two comments only work if you have downloaded the kickstart repo, not just copy pasted the
    -- init.lua. if you want these files, they are in the repository, so you can just download them and
    -- place them in the correct locations.

    -- note: next step on your neovim journey: add/configure additional plugins for kickstart
    --
    --  here are some example plugins that i've included in the kickstart repository.
    --  uncomment any of the lines below to enable them (you will need to restart nvim).

    require 'plugins.toggle_term', 
    require 'plugins.neo-tree',
    require 'plugins.cmp', 
    require 'plugins.indent_line',
    require 'plugins.autopairs',
    require 'plugins.gitsigns', -- adds gitsigns recommend keymaps
    require 'plugins.todo-comments', 
    require 'plugins.debug',
    require 'plugins.lint',
    require 'plugins.treesitter', 
    require 'plugins.telescope', 
    require 'plugins.conform', 
    require 'plugins.which-key', 

    -- note: the import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
    --    this is the easiest way to modularize your config.
    --
    --  uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
    --    for additional information, see `:help lazy.nvim-lazy.nvim-structuring-your-plugins`
    { import = 'custom.plugins' },
}, {
        ui = {
            -- if you are using a nerd font: set icons to an empty table which will use the
            -- default lazy.nvim defined nerd font icons, otherwise define a unicode icons table
            icons = vim.g.have_nerd_font and {} or {
                cmd = '⌘',
                config = '🛠',
                event = '📅',
                ft = '📂',
                init = '⚙',
                keys = '🗝',
                plugin = '🔌',
                runtime = '💻',
                require = '🌙',
                source = '📄',
                start = '🚀',
                task = '📌',
                lazy = '💤 ',
            },
        },
    })

-- the line beneath this is called `modeline`. see `:help modeline`
-- vim: ts=4 sts=4 sw=4 et
