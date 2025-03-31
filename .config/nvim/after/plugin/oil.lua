require('oil').setup({
  use_default_keymaps = false,
  keymaps = {
    ["g?"] = { "actions.show_help", mode = "n" },
    ["<CR>"] = "actions.select",
    ["<C-p>"] = "actions.preview",
    ["<C-c>"] = { "actions.close", mode = "n" },
    ["-"] = { "actions.parent", mode = "n" },
    ["_"] = { "actions.open_cwd", mode = "n" },
    ["gs"] = { "actions.change_sort", mode = "n" },
    ["gx"] = "actions.open_external",
    ["g."] = { "actions.toggle_hidden", mode = "n" },
  },
})

local function open_oil_in_split(split_cmd)
  return function()
    -- Check if current buffer is an oil buffer
    local is_oil_buffer = vim.bo.filetype == "oil"
    local current_dir = nil
    
    -- If we're in an oil buffer, get the current directory
    if is_oil_buffer then
      current_dir = require("oil").get_current_dir()
    end
    
    -- Execute the split command
    vim.cmd(split_cmd)
    
    -- Open oil with the appropriate path
    if current_dir then
      -- If we were in an oil buffer, open the same directory
      require("oil").open(current_dir)
    else
      -- If we were in a file, just open oil (which opens parent dir by default)
      require("oil").open()
    end
  end
end

vim.keymap.set("n", "<leader>ee", require("oil").open, { desc = "Open oil" })
vim.keymap.set("n", "<leader>ve", open_oil_in_split("vsplit"), { desc = "Open oil in vertical split" })
vim.keymap.set("n", "<leader>he", open_oil_in_split("split"), { desc = "Open oil in horizontal split" })
