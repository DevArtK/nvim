--[[

=====================================================================
==================== read this before continuing ====================
=====================================================================
========                                    .-----.          ========
========         .----------------------.   | === |          ========
========         |.-""""""""""""""""""-.|   |-----|          ========
========         ||                    ||   | === |          ========
========         ||   kickstart.nvim   ||   |-----|          ========
========         ||                    ||   | === |          ========
========         ||                    ||   |-----|          ========
========         ||:tutor              ||   |:::::|          ========
========         |'-..................-'|   |____o|          ========
========         `"")----------------(""`   ___________      ========
========        /::::::::::|  |::::::::::\  \ no mouse \     ========
========       /:::========|  |==hjkl==:::\  \ required \    ========
========      '""""""""""""'  '""""""""""""'  '""""""""""'   ========
========                                                     ========
=====================================================================
=====================================================================

what is kickstart?

  kickstart.nvim is *not* a distribution.

  kickstart.nvim is a starting point for your own configuration.
    the goal is that you can read every line of code, top-to-bottom, understand
    what your configuration is doing, and modify it to suit your needs.

    once you've done that, you can start exploring, configuring and tinkering to
    make neovim your own! that might mean leaving kickstart just the way it is for a while
    or immediately breaking it into modular pieces. it's up to you!

    if you don't know anything about lua, i recommend taking some time to read through
    a guide. one possible example which will only take 10-15 minutes:
      - https://learnxinyminutes.com/docs/lua/

    after understanding a bit more about lua, you can use `:help lua-guide` as a
    reference for how neovim integrates lua.
    - :help lua-guide
    - (or html version): https://neovim.io/doc/user/lua-guide.html

kickstart guide:

  todo: the very first thing you should do is to run the command `:tutor` in neovim.

    if you don't know what this means, type the following:
      - <escape key>
      - :
      - tutor
      - <enter key>

    (if you already know the neovim basics, you can skip this step.)

  once you've completed that, you can continue working through **and reading** the rest
  of the kickstart init.lua.

  next, run and read `:help`.
    this will open up a help window with some basic information
    about reading, navigating and searching the builtin help documentation.

    this should be the first place you go to look when you're stuck or confused
    with something. it's one of my favorite neovim features.

    most importantly, we provide a keymap "<space>sh" to [s]earch the [h]elp documentation,
    which is very useful when you're not exactly sure of what you're looking for.

  i have left several `:help x` comments throughout the init.lua
    these are hints about where to find more information about the relevant settings,
    plugins or neovim features used in kickstart.

   note: look for lines like this

    throughout the file. these are for you, the reader, to help you understand what is happening.
    feel free to delete them once you know what you're doing, but they should serve as a guide
    for when you are first encountering a few different constructs in your neovim config.

if you experience any errors while trying to install kickstart, run `:checkhealth` for more info.

i hope you enjoy your neovim journey,
- tj

p.s. you can delete this when you're done too. it's your config now! :)
--]]

-- set <space> as the leader key
-- see `:help mapleader`
--  note: must happen before plugins are loaded (otherwise wrong leader will be used)

-- check if no file or folder is specified
local os_name = vim.loop.os_uname().sysname

if os_name == "windows_nt" then
    if vim.fn.argc() == 0 then
        -- change to the specified directory
        vim.cmd('lcd c:\\users\\4414327\\workspace-laptop')
    end
end

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- set to true if you have a nerd font installed and selected in the terminal
vim.g.have_nerd_font = false

-- [[ setting options ]]
-- see `:help vim.opt`
-- note: you can change these options as you wish!
--  for more options, you can see `:help option-list`

-- make line numbers default
vim.opt.number = true
-- you can also add relative line numbers, to help with jumping.
--  experiment for yourself to see if you like it!
-- vim.opt.relativenumber = true

-- enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- sync clipboard between os and neovim.
--  schedule the setting after `uienter` because it can increase startup-time.
--  remove this option if you want your os clipboard to remain independent.
--  see `:help 'clipboard'`
vim.schedule(function()
    vim.opt.clipboard = 'unnamedplus'
end)

-- enable break indent
vim.opt.breakindent = true

-- save undo history
vim.opt.undofile = true

-- case-insensitive searching unless \c or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- decrease update time
vim.opt.updatetime = 250

-- decrease mapped sequence wait time
-- displays which-key popup sooner
vim.opt.timeoutlen = 300

-- configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- sets how neovim will display certain whitespace characters in the editor.
--  see `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- show which line your cursor is on
vim.opt.cursorline = true

-- minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- [[ basic keymaps ]]
--  see `:help vim.keymap.set()`

-- clear highlights on search when pressing <esc> in normal mode
--  see `:help hlsearch`
vim.keymap.set('n', '<esc>', '<cmd>nohlsearch<cr>')

-- diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'open diagnostic [q]uickfix list' })

-- exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. otherwise, you normally need to press <c-\><c-n>, which
-- is not what someone will guess without a bit more experience.
--
-- note: this won't work in all terminal emulators/tmux/etc. try your own mapping
-- or just use <c-\><c-n> to exit terminal mode
vim.keymap.set('t', '<esc><esc>', '<c-\\><c-n>', { desc = 'exit terminal mode' })

-- tip: disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "use h to move!!"<cr>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "use l to move!!"<cr>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "use k to move!!"<cr>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "use j to move!!"<cr>')

-- keybinds to make split navigation easier.
--  use ctrl+<hjkl> to switch between windows
--
--  see `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<c-h>', '<c-w><c-h>', { desc = 'move focus to the left window' })
vim.keymap.set('n', '<c-l>', '<c-w><c-l>', { desc = 'move focus to the right window' })
vim.keymap.set('n', '<c-j>', '<c-w><c-j>', { desc = 'move focus to the lower window' })
vim.keymap.set('n', '<c-k>', '<c-w><c-k>', { desc = 'move focus to the upper window' })

-- [[ basic autocommands ]]
--  see `:help lua-guide-autocommands`

-- highlight when yanking (copying) text
--  try it with `yap` in normal mode
--  see `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('textyankpost', {
    desc = 'highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- [[ install `lazy.nvim` plugin manager ]]
--    see `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
    if vim.v.shell_error ~= 0 then
        error('error cloning lazy.nvim:\n' .. out)
    end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ configure and install plugins ]]
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
    --

    -- here is a more advanced example where we pass configuration
    -- options to `gitsigns.nvim`. this is equivalent to the following lua:
    --    require('gitsigns').setup({ ... })
    --
    -- see `:help gitsigns` to understand what the configuration keys do
    { -- adds git related signs to the gutter, as well as utilities for managing changes
        'lewis6991/gitsigns.nvim',
        opts = {
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
            },
        },
    },

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

    {                       -- useful plugin to show you pending keybinds.
        'folke/which-key.nvim',
        event = 'vimenter', -- sets the loading event to 'vimenter'
        opts = {
            icons = {
                -- set icon mappings to true if you have a nerd font
                mappings = vim.g.have_nerd_font,
                -- if you are using a nerd font: set icons.keys to an empty table which will use the
                -- default whick-key.nvim defined nerd font icons, otherwise define a string table
                keys = vim.g.have_nerd_font and {} or {
                    up = '<up> ',
                    down = '<down> ',
                    left = '<left> ',
                    right = '<right> ',
                    c = '<c-…> ',
                    m = '<m-…> ',
                    d = '<d-…> ',
                    s = '<s-…> ',
                    cr = '<cr> ',
                    esc = '<esc> ',
                    scrollwheeldown = '<scrollwheeldown> ',
                    scrollwheelup = '<scrollwheelup> ',
                    nl = '<nl> ',
                    bs = '<bs> ',
                    space = '<space> ',
                    tab = '<tab> ',
                    f1 = '<f1>',
                    f2 = '<f2>',
                    f3 = '<f3>',
                    f4 = '<f4>',
                    f5 = '<f5>',
                    f6 = '<f6>',
                    f7 = '<f7>',
                    f8 = '<f8>',
                    f9 = '<f9>',
                    f10 = '<f10>',
                    f11 = '<f11>',
                    f12 = '<f12>',
                },
            },

            -- document existing key chains
            spec = {
                { '<leader>c', group = '[c]ode',     mode = { 'n', 'x' } },
                { '<leader>d', group = '[d]ocument' },
                { '<leader>r', group = '[r]ename' },
                { '<leader>s', group = '[s]earch' },
                { '<leader>w', group = '[w]orkspace' },
                { '<leader>t', group = '[t]oggle' },
                { '<leader>h', group = 'git [h]unk', mode = { 'n', 'v' } },
            },
        },
    },

    -- note: plugins can specify dependencies.
    --
    -- the dependencies are proper plugin specifications as well - anything
    -- you do for a plugin at the top level, you can do for a dependency.
    --
    -- use the `dependencies` key to specify the dependencies of a particular plugin

    { -- fuzzy finder (files, lsp, etc)
        'nvim-telescope/telescope.nvim',
        event = 'vimenter',
        branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            { -- if encountering errors, see telescope-fzf-native readme for installation instructions
                'nvim-telescope/telescope-fzf-native.nvim',

                -- `build` is used to run some command when the plugin is installed/updated.
                -- this is only run then, not every time neovim starts up.
                build = 'make',

                -- `cond` is a condition used to determine whether this plugin should be
                -- installed and loaded.
                cond = function()
                    return vim.fn.executable 'make' == 1
                end,
            },
            { 'nvim-telescope/telescope-ui-select.nvim' },

            -- useful for getting pretty icons, but requires a nerd font.
            { 'nvim-tree/nvim-web-devicons',            enabled = vim.g.have_nerd_font },
        },
        config = function()
            -- telescope is a fuzzy finder that comes with a lot of different things that
            -- it can fuzzy find! it's more than just a "file finder", it can search
            -- many different aspects of neovim, your workspace, lsp, and more!
            --
            -- the easiest way to use telescope, is to start by doing something like:
            --  :telescope help_tags
            --
            -- after running this command, a window will open up and you're able to
            -- type in the prompt window. you'll see a list of `help_tags` options and
            -- a corresponding preview of the help.
            --
            -- two important keymaps to use while in telescope are:
            --  - insert mode: <c-/>
            --  - normal mode: ?
            --
            -- this opens a window that shows you all of the keymaps for the current
            -- telescope picker. this is really useful to discover what telescope can
            -- do as well as how to actually do it!

            -- [[ configure telescope ]]
            -- see `:help telescope` and `:help telescope.setup()`
            require('telescope').setup {
                -- you can put your default mappings / updates / etc. in here
                --  all the info you're looking for is in `:help telescope.setup()`
                --
                -- defaults = {
                --   mappings = {
                --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
                --   },
                -- },
                -- pickers = {}
                extensions = {
                    ['ui-select'] = {
                        require('telescope.themes').get_dropdown(),
                    },
                },
            }

            -- enable telescope extensions if they are installed
            pcall(require('telescope').load_extension, 'fzf')
            pcall(require('telescope').load_extension, 'ui-select')

            -- see `:help telescope.builtin`
            local builtin = require 'telescope.builtin'
            vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[s]earch [h]elp' })
            vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[s]earch [k]eymaps' })
            vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[s]earch [f]iles' })
            vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[s]earch [s]elect telescope' })
            vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[s]earch current [w]ord' })
            vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[s]earch by [g]rep' })
            vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[s]earch [d]iagnostics' })
            vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[s]earch [r]esume' })
            vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[s]earch recent files ("." for repeat)' })
            vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] find existing buffers' })

            -- slightly advanced example of overriding default behavior and theme
            vim.keymap.set('n', '<leader>/', function()
                -- you can pass additional configuration to telescope to change the theme, layout, etc.
                builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                    winblend = 10,
                    previewer = false,
                })
            end, { desc = '[/] fuzzily search in current buffer' })

            -- it's also possible to pass additional configuration options.
            --  see `:help telescope.builtin.live_grep()` for information about particular keys
            vim.keymap.set('n', '<leader>s/', function()
                builtin.live_grep {
                    grep_open_files = true,
                    prompt_title = 'live grep in open files',
                }
            end, { desc = '[s]earch [/] in open files' })

            -- shortcut for searching your neovim configuration files
            vim.keymap.set('n', '<leader>sn', function()
                builtin.find_files { cwd = vim.fn.stdpath 'config' }
            end, { desc = '[s]earch [n]eovim files' })
        end,
    },

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
                -- rust_analyzer = {},
                -- ... etc. see `:help lspconfig-all` for a list of all the pre-configured lsps
                --
                -- some languages (like typescript) have entire language plugins that can be useful:
                --    https://github.com/pmizio/typescript-tools.nvim
                --
                -- but for many setups, the lsp (`ts_ls`) will work just fine
                -- ts_ls = {},
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

    { -- autoformat
        'stevearc/conform.nvim',
        event = { 'bufwritepre' },
        cmd = { 'conforminfo' },
        keys = {
            {
                '<leader>f',
                function()
                    require('conform').format { async = true, lsp_format = 'fallback' }
                end,
                mode = '',
                desc = '[f]ormat buffer',
            },
        },
        opts = {
            notify_on_error = false,
            format_on_save = function(bufnr)
                -- disable "format_on_save lsp_fallback" for languages that don't
                -- have a well standardized coding style. you can add additional
                -- languages here or re-enable it for the disabled ones.
                local disable_filetypes = { c = true, cpp = true }
                local lsp_format_opt
                if disable_filetypes[vim.bo[bufnr].filetype] then
                    lsp_format_opt = 'never'
                else
                    lsp_format_opt = 'fallback'
                end
                return {
                    timeout_ms = 500,
                    lsp_format = lsp_format_opt,
                }
            end,
            formatters_by_ft = {
                lua = { 'stylua' },
                -- conform can also run multiple formatters sequentially
                -- python = { "isort", "black" },
                --
                -- you can use 'stop_after_first' to run the first available formatter from the list
                -- javascript = { "prettierd", "prettier", stop_after_first = true },
            },
        },
    },

    { -- autocompletion
        'hrsh7th/nvim-cmp',
        event = 'insertenter',
        dependencies = {
            -- snippet engine & its associated nvim-cmp source
            {
                'l3mon4d3/luasnip',
                build = (function()
                    -- build step is needed for regex support in snippets.
                    -- this step is not supported in many windows environments.
                    -- remove the below condition to re-enable on windows.
                    if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
                        return
                    end
                    return 'make install_jsregexp'
                end)(),
                dependencies = {
                    -- `friendly-snippets` contains a variety of premade snippets.
                    --    see the readme about individual language/framework/plugin snippets:
                    --    https://github.com/rafamadriz/friendly-snippets
                    -- {
                    --   'rafamadriz/friendly-snippets',
                    --   config = function()
                    --     require('luasnip.loaders.from_vscode').lazy_load()
                    --   end,
                    -- },
                },
            },
            'saadparwaiz1/cmp_luasnip',

            -- adds other completion capabilities.
            --  nvim-cmp does not ship with all sources by default. they are split
            --  into multiple repos for maintenance purposes.
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path',
        },
        config = function()
            -- see `:help cmp`
            local cmp = require 'cmp'
            local luasnip = require 'luasnip'
            luasnip.config.setup {}

            cmp.setup {
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                completion = { completeopt = 'menu,menuone,noinsert' },

                -- for an understanding of why these mappings were
                -- chosen, you will need to read `:help ins-completion`
                --
                -- no, but seriously. please read `:help ins-completion`, it is really good!
                mapping = cmp.mapping.preset.insert {
                    -- select the [n]ext item
                    ['<c-n>'] = cmp.mapping.select_next_item(),
                    -- select the [p]revious item
                    ['<c-p>'] = cmp.mapping.select_prev_item(),

                    -- scroll the documentation window [b]ack / [f]orward
                    ['<c-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<c-f>'] = cmp.mapping.scroll_docs(4),

                    -- accept ([y]es) the completion.
                    --  this will auto-import if your lsp supports it.
                    --  this will expand snippets if the lsp sent a snippet.
                    ['<c-y>'] = cmp.mapping.confirm { select = true },

                    -- if you prefer more traditional completion keymaps,
                    -- you can uncomment the following lines
                    --['<cr>'] = cmp.mapping.confirm { select = true },
                    --['<tab>'] = cmp.mapping.select_next_item(),
                    --['<s-tab>'] = cmp.mapping.select_prev_item(),

                    -- manually trigger a completion from nvim-cmp.
                    --  generally you don't need this, because nvim-cmp will display
                    --  completions whenever it has completion options available.
                    ['<c-space>'] = cmp.mapping.complete {},

                    -- think of <c-l> as moving to the right of your snippet expansion.
                    --  so if you have a snippet that's like:
                    --  function $name($args)
                    --    $body
                    --  end
                    --
                    -- <c-l> will move you to the right of each of the expansion locations.
                    -- <c-h> is similar, except moving you backwards.
                    ['<c-l>'] = cmp.mapping(function()
                        if luasnip.expand_or_locally_jumpable() then
                            luasnip.expand_or_jump()
                        end
                    end, { 'i', 's' }),
                    ['<c-h>'] = cmp.mapping(function()
                        if luasnip.locally_jumpable(-1) then
                            luasnip.jump(-1)
                        end
                    end, { 'i', 's' }),

                    -- for more advanced luasnip keymaps (e.g. selecting choice nodes, expansion) see:
                    --    https://github.com/l3mon4d3/luasnip?tab=readme-ov-file#keymaps
                },
                sources = {
                    {
                        name = 'lazydev',
                        -- set group index to 0 to skip loading luals completions as lazydev recommends it
                        group_index = 0,
                    },
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    { name = 'path' },
                },
            }
        end,
    },
    --
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
    { 'folke/todo-comments.nvim', event = 'vimenter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

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
    { -- highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        build = ':tsupdate',
        main = 'nvim-treesitter.configs', -- sets main module to use for opts
        -- [[ configure treesitter ]] see `:help nvim-treesitter`
        opts = {
            ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
            -- autoinstall languages that are not installed
            auto_install = true,
            highlight = {
                enable = true,
                -- some languages depend on vim's regex highlighting system (such as ruby) for indent rules.
                --  if you are experiencing weird indenting issues, add the language to
                --  the list of additional_vim_regex_highlighting and disabled languages for indent.
                additional_vim_regex_highlighting = { 'ruby' },
            },
            indent = { enable = true, disable = { 'ruby' } },
        },
        -- there are additional nvim-treesitter modules that you can use to interact
        -- with nvim-treesitter. you should go explore a few and see what interests you:
        --
        --    - incremental selection: included, see `:help nvim-treesitter-incremental-selection-mod`
        --    - show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
        --    - treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    },

    -- the following two comments only work if you have downloaded the kickstart repo, not just copy pasted the
    -- init.lua. if you want these files, they are in the repository, so you can just download them and
    -- place them in the correct locations.

    -- note: next step on your neovim journey: add/configure additional plugins for kickstart
    --
    --  here are some example plugins that i've included in the kickstart repository.
    --  uncomment any of the lines below to enable them (you will need to restart nvim).
    --
    require 'kickstart.plugins.debug',
    require 'kickstart.plugins.indent_line',
    require 'kickstart.plugins.lint',
    require 'kickstart.plugins.autopairs',
    require 'kickstart.plugins.neo-tree',
    require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps

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
