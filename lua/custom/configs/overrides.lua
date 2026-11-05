local M = {}

M.treesitter = {
  ensure_installed = {
    "vim",
    "lua",
    "html",
    "css",
    "javascript",
    "typescript",
    "tsx",
    "c",
    "markdown",
    "markdown_inline",
    "python",
    "go",
    "yaml",
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true,
    -- Neovim 0.12 crashes markdown_inline injections with
    -- "attempt to call method 'range' (a nil value)".
    disable = { "markdown", "markdown_inline" },
  },
  indent = {
    enable = true,
    disable = { "markdown" },
  },
}

M.mason = {
  ensure_installed = {
    -- shell stuff
    "shfmt",

    -- lua stuff
    "lua-language-server",
    "stylua",

    -- web dev stuff
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "prettier",

    -- c/cpp stuff
    "clangd",
    -- python
    "ruff",
    "pyright",
    -- go
    "gopls",
    "goimports",
    "golangci-lint",
  },
}

-- git support in nvimtree
M.nvimtree = {
  git = {
    enable = true,
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
}

return M
