-- make middle-click copy work in Neovim.

vim.api.nvim_create_autocmd('CursorMoved', {
  desc = 'Keep * synced with selection',
  callback = function()
    local mode = vim.fn.mode(false)
    if mode == 'v' or mode == 'V' or mode == '\22' then
      vim.cmd([[silent norm "*ygv]])
    end
  end,
})
