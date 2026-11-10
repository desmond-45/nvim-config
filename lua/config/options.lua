local opt = vim.opt
local g = vim.g

g.mapleader = " "

-- Disable netrw so nvim-tree can own directory opens (nvim .)
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

-- block in normal; thin | bar in insert
opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50"

opt.laststatus = 3
opt.showmode = false

opt.clipboard = "unnamedplus"
opt.cursorline = true

opt.expandtab = true
opt.shiftwidth = 4
opt.smartindent = true
opt.tabstop = 4
opt.softtabstop = 4
opt.scrolloff = 8
opt.colorcolumn = "79"

opt.fillchars = { eob = " " }
opt.ignorecase = true
opt.smartcase = true
opt.mouse = "a"

opt.number = true
opt.numberwidth = 2
opt.ruler = false
opt.relativenumber = true

opt.shortmess:append "sI"

opt.signcolumn = "yes"
opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true
opt.timeoutlen = 400

-- No swap/backup prompts; undo history still kept via undofile
opt.swapfile = false
opt.backup = false
opt.undofile = true

opt.updatetime = 250
opt.whichwrap:append "<>[]hl"

-- Disable providers we don't use
-- ipairs loops a list: {"node", "perl", "python3", "ruby"} and
-- disables the provider for each of them by setting g.loaded_<provider>_provider to 0
for _, provider in ipairs { "node", "perl", "python3", "ruby" } do
  g["loaded_" .. provider .. "_provider"] = 0
end

-- Set the path to include Mason's bin directory for LSPs and other tools
local is_windows = vim.loop.os_uname().sysname == "Windows_NT"
vim.env.PATH = vim.fn.stdpath "data" .. "/mason/bin" .. (is_windows and ";" or ":") .. vim.env.PATH
