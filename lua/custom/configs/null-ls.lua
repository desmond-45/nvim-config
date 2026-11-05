local null_ls = require "null-ls"

local sources = {
  require("none-ls.diagnostics.ruff").with {
    extra_args = {
      "--config",
      "lint.ignore = ['I']",
      "--config",
      "preview = true",
    },
  },
  require("none-ls.formatting.ruff_format").with {
    extra_args = {
      "--config",
      "line-length = 79",
      "--config",
      "format.quote-style = 'single'",
      "--config",
      "format.docstring-code-format = true",
      "--config",
      "format.docstring-code-line-length = 79",
    },
  },
  null_ls.builtins.formatting.prettier.with {
    filetypes = {
      "json",
      "yaml",
      "markdown",
      "html",
      "css",
      "python",
      "lua",
      "javascript",
      "jsx",
      "tsx",
    },
  },
  null_ls.builtins.formatting.stylua,
  null_ls.builtins.formatting.shfmt.with {
    args = { "-i", "4" },
  },
  null_ls.builtins.formatting.goimports,
}

null_ls.setup {
  sources = sources,
}
