-- https://github.com/lewis6991/gitsigns.nvim
-- here is a more advanced example where we pass configuration
-- options to `gitsigns.nvim`. this is equivalent to the following lua:
--    require('gitsigns').setup({ ... })
--
-- see `:help gitsigns` to understand what the configuration keys do
return { -- adds git related signs to the gutter, as well as utilities for managing changes
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
}
