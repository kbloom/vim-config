  -- mouse selection to x11 primary cliboard
  -- single click - covers click+drag
  vim.keymap.set('v', '<LeftRelease>', '"*ygv')
  -- double click - selects word
  vim.keymap.set('v', '<2-LeftRelease>', '"*ygv')
  vim.keymap.set('i', '<2-LeftRelease>', '<c-o>"*y<c-o>gv')
  -- triple click - selects line
  vim.keymap.set('v', '<3-LeftRelease>', '"*ygv')
