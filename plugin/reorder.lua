--- Scans a raw text selection to extract distinct items and any list conjunction.
-- @param selection string: The raw list text (e.g. "apple, banana, and orange")
-- @return table, string: An array of trimmed item strings, and the raw conjunction string (or "").
local function analyze_list(selection)
  local items = {}
  local conj = ""

  -- 1. Split the entire selection cleanly by commas
  --    Using [^,]+ matches everything that isn't a comma
  for part in string.gmatch(selection, "[^,]+") do
    local trimmed = vim.trim(part)

    if trimmed ~= "" then
      -- 2. Check if this part starts with a conjunction ("and " or "or ")
      --    ^and%s+ matches "and" followed by one or more spaces at the start
      --    ^or%s+  matches "or" followed by one or more spaces at the start
      local conj_match = string.match(trimmed, "^and%s+") or string.match(trimmed, "^or%s+")

      if conj_match then
        -- We found the conjunction! Save it (e.g., "and ")
        conj = conj_match

        -- Strip the conjunction off the front of the item text
        -- so only the clean item name goes into our list
        trimmed = vim.trim(string.sub(trimmed, #conj_match + 1))
      end

      -- Only keep it if it isn't an empty string after stripping
      if trimmed ~= "" then
        table.insert(items, trimmed)
      end
    end
  end

  return items, conj
end

--- Coordinates the list decomposition, reordering, and re-assembly.
-- @param selection string: The raw text selection to process.
-- @param order table: An array of 1-based indices defining the new order.
-- @return string: The reordered text list.
local function parse_and_reorder(selection, order)
  local items, conj = analyze_list(selection)

  -- Safely return original string if no valid items were parsed
  if #items == 0 then return selection end

  -- Permute items based on the provided order mapping
  local permuted_items = {}
  for _, index in ipairs(order) do
    if items[index] then
      table.insert(permuted_items, items[index])
    end
  end

  -- Rejoin items using the discovered grammatical style
  local clean_conj = vim.trim(conj)
  if #permuted_items < 3 then
    local separator = (clean_conj ~= "") and (" " .. clean_conj .. " ") or ", "
    return table.concat(permuted_items, separator)
  else
    local last_item = table.remove(permuted_items)
    if clean_conj ~= "" then
      return table.concat(permuted_items, ", ") .. ", " .. clean_conj .. " " .. last_item
    else
      return table.concat(permuted_items, ", ") .. ", " .. last_item
    end
  end
end

local function get_selection_positions()
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")

  local start_line = start_pos[2] - 1
  local start_col = start_pos[3] - 1
  local end_line = end_pos[2] - 1
  local end_col = end_pos[3]
  local vmode = vim.fn.visualmode()

  -- Get the exact line contents of the last line in the selection
  local last_line_text = vim.api.nvim_buf_get_lines(0, end_line, end_line + 1, false)[1] or ""
  local max_col = string.len(last_line_text)

  -- Clamp end_col so it never exceeds the actual line byte length
  if end_col > max_col then
    end_col = max_col
  end

  return start_line, start_col, end_line, end_col
end

--- Neovim User Command handler. Manages UI arguments and text buffer I/O.
-- @param opts table: The options table provided by nvim_create_user_command
local function reorder_command_handler(opts)
  -- 1. Parse arguments (e.g., "3,1,2" -> {3, 1, 2})
  local order = {}
  for num in string.gmatch(opts.args, "[^,]+") do
    table.insert(order, tonumber(num))
  end

  start_line, start_col, end_line, end_col = get_selection_positions()

  -- 3. Extract text from the document
  local lines = vim.api.nvim_buf_get_text(0, start_line, start_col, end_line, end_col, {})
  local selection = table.concat(lines, "\n")
  print(vim.inspect(selection))

  -- 4. Hand off text data to processing engine
  local result = parse_and_reorder(selection, order)
  local replacement_lines = vim.split(result, "\n")

  -- 5. Push processed text back out to the document safely
  if vim.fn.visualmode() == "V" then
    vim.api.nvim_buf_set_lines(0, start_line, end_line + 1, false, replacement_lines)
  else
    vim.api.nvim_buf_set_text(0, start_line, start_col, end_line, end_col, replacement_lines)
  end
end

-- Define user command interface
vim.api.nvim_create_user_command("Reorder", reorder_command_handler, { range = true, nargs = 1 })
