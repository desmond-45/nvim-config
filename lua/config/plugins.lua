local plugins = {
  require "config.plugins.rose-pine",

  "nvim-lua/plenary.nvim",
  "nvim-tree/nvim-web-devicons",

  require "config.plugins.bufferline",
  require "config.plugins.lualine",
  require "config.plugins.indent-blankline",
  require "config.plugins.colorizer",
  require "config.plugins.nvim-tree",
  require "config.plugins.telescope",
  require "config.plugins.treesitter",
  require "config.plugins.comment",
  require "config.plugins.gitsigns",
  require "config.plugins.mason",
  require "config.plugins.lspconfig",
  require "config.plugins.none-ls",
  require "config.plugins.cmp",
  require "config.plugins.aerial",
}

vim.list_extend(plugins, require "config.plugins.misc")

return plugins
