return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    -- nvim-treesitter master does not support Neovim 0.12; markdown
    -- parsers crash highlighter with "range (a nil value)". Keep
    -- markdown on regex syntax only.
    require("nvim-treesitter.configs").setup {
      ensure_installed = {
        "vim",
        "lua",
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "c",
        "python",
        "go",
        "yaml",
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
        disable = { "markdown", "markdown_inline" },
      },
      indent = {
        enable = true,
        disable = { "markdown" },
      },
    }

    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "markdown", "markdown.mdx" },
      callback = function(ev)
        pcall(vim.treesitter.stop, ev.buf)
      end,
    })
  end,
}
