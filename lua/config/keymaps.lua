-- ============================================================
-- keymaps.lua
--
-- vim.keymap.set(mode, keys, action, opts)
--   mode   = "n" normal, "i" insert, "v" visual, "t" terminal, "x" visual-only
--   action = string (keys/command) OR function() ... end
-- ============================================================

local map = vim.keymap.set

-- ---------- your custom maps ----------

-- ; opens command-line (same as :)
map("n", ";", ":", { desc = "Enter command mode", nowait = true })

-- Space + y + p = copy absolute path of current file to clipboard
map("n", "<leader>yp", function()
  vim.fn.setreg("+", vim.fn.expand "%:p")
end, { desc = "Copy current file path to clipboard" })

-- Clear search highlight
map("n", "<Esc>", "<cmd>noh<CR>", { desc = "Clear highlights" })

-- Move between windows
map("n", "<C-h>", "<C-w>h", { desc = "Window left" })
map("n", "<C-l>", "<C-w>l", { desc = "Window right" })
map("n", "<C-j>", "<C-w>j", { desc = "Window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Window up" })

-- Move in insert mode with Ctrl + hjkl
map("i", "<C-h>", "<Left>", { desc = "Move left" })
map("i", "<C-l>", "<Right>", { desc = "Move right" })
map("i", "<C-j>", "<Down>", { desc = "Move down" })
map("i", "<C-k>", "<Up>", { desc = "Move up" })

-- Copy whole file to clipboard
map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "Copy whole file" })

-- Toggle line numbers
map("n", "<leader>n", "<cmd>set nu!<CR>", { desc = "Toggle line number" })
map("n", "<leader>rn", "<cmd>set rnu!<CR>", { desc = "Toggle relative number" })

-- Move through wrapped lines naturally
map({ "n", "x" }, "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { desc = "Move down", expr = true })
map({ "n", "x" }, "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { desc = "Move up", expr = true })
map({ "n", "v" }, "<Up>", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { desc = "Move up", expr = true })
map({ "n", "v" }, "<Down>", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { desc = "Move down", expr = true })

-- New empty buffer
map("n", "<leader>b", "<cmd>enew<CR>", { desc = "New buffer" })

-- Format with LSP / none-ls
map("n", "<leader>fm", function()
  vim.lsp.buf.format { async = true }
end, { desc = "LSP formatting" })

-- Escape terminal mode
map("t", "<C-x>", "<C-\\><C-N>", { desc = "Escape terminal mode" })

-- In visual paste, don't replace clipboard with replaced text
map("x", "p", 'p:let @+=@0<CR>:let @"=@0<CR>', {
  desc = "Dont copy replaced text",
  silent = true,
})

map("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
map("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Prev buffer" })
map("n", "<leader>x", "<cmd>bdelete<CR>", { desc = "Close buffer" })

-- ---------- comment ----------

map("n", "<leader>/", function()
  require("Comment.api").toggle.linewise.current()
end, { desc = "Toggle comment" })

map(
  "v",
  "<leader>/",
  "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
  { desc = "Toggle comment" }
)

-- ---------- LSP ----------
-- These are global; they no-op usefully if no LSP is attached.

map("n", "gD", function()
  vim.lsp.buf.declaration()
end, { desc = "LSP declaration" })

map("n", "gd", function()
  vim.lsp.buf.definition()
end, { desc = "LSP definition" })

map("n", "K", function()
  vim.lsp.buf.hover()
end, { desc = "LSP hover" })

map("n", "gi", function()
  vim.lsp.buf.implementation()
end, { desc = "LSP implementation" })

map("n", "<leader>ls", function()
  vim.lsp.buf.signature_help()
end, { desc = "LSP signature help" })

map("n", "<leader>D", function()
  vim.lsp.buf.type_definition()
end, { desc = "LSP type definition" })

map("n", "<leader>ra", function()
  vim.lsp.buf.rename()
end, { desc = "LSP rename" })

map("n", "<leader>ca", function()
  vim.lsp.buf.code_action()
end, { desc = "LSP code action" })

map("n", "gr", function()
  vim.lsp.buf.references()
end, { desc = "LSP references" })

map("n", "<leader>f", function()
  vim.diagnostic.open_float { border = "rounded" }
end, { desc = "Floating diagnostic" })

map("n", "[d", function()
  vim.diagnostic.goto_prev { float = { border = "rounded" } }
end, { desc = "Prev diagnostic" })

map("n", "]d", function()
  vim.diagnostic.goto_next { float = { border = "rounded" } }
end, { desc = "Next diagnostic" })

map("n", "<leader>q", function()
  vim.diagnostic.setloclist()
end, { desc = "Diagnostic list" })

-- ---------- nvim-tree ----------

map("n", "<C-b>", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle nvimtree" })
map("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", { desc = "Focus nvimtree" })

-- ---------- telescope ----------

map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
map("n", "<leader>fa", "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>", { desc = "Find all" })
map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "Live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Find buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Help page" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "Find oldfiles" })
map("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "Find in current buffer" })
map("n", "<leader>cm", "<cmd>Telescope git_commits<CR>", { desc = "Git commits" })
map("n", "<leader>gt", "<cmd>Telescope git_status<CR>", { desc = "Git status" })
map("n", "<leader>ma", "<cmd>Telescope marks<CR>", { desc = "Telescope marks" })

-- ---------- which-key ----------

map("n", "<leader>wK", function()
  vim.cmd "WhichKey"
end, { desc = "Which-key all keymaps" })

map("n", "<leader>wk", function()
  local input = vim.fn.input "WhichKey: "
  vim.cmd("WhichKey " .. input)
end, { desc = "Which-key query lookup" })

-- ---------- gitsigns ----------

map("n", "]c", function()
  if vim.wo.diff then
    return "]c"
  end
  vim.schedule(function()
    require("gitsigns").next_hunk()
  end)
  return "<Ignore>"
end, { desc = "Jump to next hunk", expr = true })

map("n", "[c", function()
  if vim.wo.diff then
    return "[c"
  end
  vim.schedule(function()
    require("gitsigns").prev_hunk()
  end)
  return "<Ignore>"
end, { desc = "Jump to prev hunk", expr = true })

map("n", "<leader>rh", function()
  require("gitsigns").reset_hunk()
end, { desc = "Reset hunk" })

map("n", "<leader>ph", function()
  require("gitsigns").preview_hunk()
end, { desc = "Preview hunk" })

map("n", "<leader>gb", function()
  require("gitsigns").blame_line()
end, { desc = "Blame line" })

map("n", "<leader>td", function()
  require("gitsigns").toggle_deleted()
end, { desc = "Toggle deleted" })

-- ---------- aerial (your custom plugin) ----------

map("n", "<leader>a", "<cmd>AerialToggle!<CR>", { desc = "Toggle aerial" })
