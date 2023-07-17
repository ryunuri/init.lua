-- key mappings
vim.cmd([[
  " default key mappings
  " let HiSet   = 'f<CR>'
  " let HiErase = 'f<BS>'
  " let HiClear = 'f<C-L>'
  " let HiFind  = 'f<Tab>'
  " let HiSetSL = 't<CR>'

  " jump key mappings
  nn n  <Cmd>call HiSearch('n')<CR>
  nn N  <Cmd>call HiSearch('N')<CR>

  " :noh commmand mapping, if there isn't
  nn <Esc>n  <Cmd>noh<CR>

  " find key mappings
  nn -        <Cmd>Hi/next<CR>
  nn _        <Cmd>Hi/previous<CR>
  nn f<Left>  <Cmd>Hi/older<CR>
  nn f<Right> <Cmd>Hi/newer<CR>
]])

-- directory to store highlight files
vim.g.HiKeywords = '~/.config/nvim/after/vim-highlighter'
