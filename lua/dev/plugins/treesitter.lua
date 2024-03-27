return {
    "nvim-treesitter/nvim-treesitter",
    config = function()
        local treesitter = require("nvim-treesitter")

        treesitter.setup({
            ensure_installed = {
                "bash",
                "c",
                "haskell",
                "html",
                "javascript",
                "jq",
                "json",
                "kotlin",
                "lua",
                "nix",
                "python",
                "sql",
                "terraform",
                "tmux",
                "typescript",
                "xml",
                "yaml",
                "vim"
            },
            highlight = {
                enable = true,
            },
            indent = {
                enable = true
            },
            auto_install = true,
        })
    end
}
