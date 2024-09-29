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

    require 'plugins.lsp', 
    require 'plugins.toggle_term', -- terminal
    require 'plugins.neo-tree', -- file explorer
    require 'plugins.cmp',  -- auto completion
    require 'plugins.indent_line', -- indentation
    require 'plugins.autopairs', -- auto brackets
    require 'plugins.gitsigns', -- adds gitsigns recommend keymaps
    require 'plugins.todo-comments', -- improved comments
    require 'plugins.debug', -- debugging
    require 'plugins.lint', -- linting
    require 'plugins.treesitter', -- parsing
    require 'plugins.telescope', -- searching
    require 'plugins.conform', -- formatting
    require 'plugins.which-key', -- keymaps ui

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
