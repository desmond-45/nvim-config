-- config/lazy.lua

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

-- If lazy.nvim is missing, clone it from GitHub
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  }
end

-- Put lazy.nvim on Neovim's runtime path so `require("lazy")` works
vim.opt.rtp:prepend(lazypath)

-- setup() takes a list of plugin tables
require("lazy").setup(require "config.plugins")
