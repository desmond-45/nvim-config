return {
  "nvimtools/none-ls.nvim",
  lazy = false,
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
    "nvim-lua/plenary.nvim",
  },
  config = function()
    require "config.null-ls"
  end,
}
