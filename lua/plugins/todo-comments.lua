-- https://github.com/folke/todo-comments.nvim
return { 
  'folke/todo-comments.nvim', 
  event = 'vimenter', 
  dependencies = { 'nvim-lua/plenary.nvim' }, 
  opts = { signs = false } 
}
