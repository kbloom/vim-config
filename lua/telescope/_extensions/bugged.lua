local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local sorters = require "telescope.sorters"
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"


local insert = function(opts)
  opts = opts or {}
  pickers.new(opts, {
    prompt_title = "bugs",
    finder = finders.new_oneshot_job({'/usr/bin/bugged', 'search', '--columns', 'issue,summary'}, opts),
    sorter = sorters.get_fuzzy_file(),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        local bugnum = string.match(selection[1], "%d+")
        vim.api.nvim_put({ bugnum }, "", false, true)
      end)
      return true
    end,    
  }):find()
end

return require("telescope").register_extension {
  setup = function(ext_config, config)
    -- access extension config and user config
  end,
  exports = {
    bugged = insert
  },
}
