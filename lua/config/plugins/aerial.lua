return {
  "stevearc/aerial.nvim",
  cmd = { "AerialToggle", "AerialOpen", "AerialPrev", "AerialNext" },
  config = function()
    require("aerial").setup {
      max_width = { 40, 0.25 },
      resize_to_content = true,
      on_attach = function(bufnr)
        vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
        vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
      end,
    }
  end,
}
