---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },

    -- Copy file path to clipboard
    ["<leader>yp"] = {
      function()
        vim.fn.setreg("+", vim.fn.expand "%:p")
      end,
      "Copy file path to clipboard",
    },
  },
}

-- more keybinds!

return M
