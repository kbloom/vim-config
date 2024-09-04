_G.gron_foldlevel = function(linenum)
   local splits = vim.split(vim.fn.getline(linenum), " = ");
   local matchesLastLine = true;
   if linenum > 1 then
      local prevsplits = vim.split(vim.fn.getline(linenum-1), " = ");
      matchesLastLine = prevsplits[1] == splits[1]
   end
   local value = splits[2];
   local value = splits[2];
   local numfields = #vim.split(splits[1], ".", {plain=true});
   if value == "{};" or value == "[];" then
     return ">" .. numfields;
   elseif not matchesLastLine then
     return ">" .. numfields;
   else
      return numfields
   end
end

vim.opt.foldexpr = 'v:lua.gron_foldlevel(v:lnum)'
vim.opt.foldmethod = 'expr'
vim.opt.foldlevel = 1
