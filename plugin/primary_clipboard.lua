-- make drag-to-copy work in Neovim.

vim.keymap.set('v', '<LeftRelease>', function()
  -- 1. Get the raw start (anchor) and end (cursor) positions
  local _, s_row, s_col, _ = unpack(vim.fn.getpos("v"))
  local _, e_row, e_col, _ = unpack(vim.fn.getpos("."))

  -- 2. Swap if dragging backwards (upwards or leftwards on the same line)
  if s_row > e_row or (s_row == e_row and s_col > e_col) then
    s_row, e_row = e_row, s_row
    s_col, e_col = e_col, s_col
  end

  -- 3. Extract the text lines from the buffer safely (adjusting 1-index to 0-index)
  local lines = vim.api.nvim_buf_get_text(0, s_row - 1, s_col - 1, e_row - 1, e_col, {})

  -- 4. Set the '*' register with our selected lines
  vim.fn.setreg('*', lines, 'v')
end, { desc = "Set * register from mouse selection using setreg" })
