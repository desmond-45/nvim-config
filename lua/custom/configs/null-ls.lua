-- local null_ls = require "null-ls"
-- local b = null_ls.builtins
--
-- local sources = {
--   -- webdev stuff
--   b.formatting.deno_fmt, -- choosed deno for ts/js files cuz its very fast!
--   b.formatting.prettier.with { filetypes = { "html", "markdown", "css", "python", "javascript", "go", "lua" } }, -- so prettier works only on these filetypes
--
--   -- Lua
--   b.formatting.stylua,
--
--   -- cpp
--   b.formatting.clang_format,
--
--   -- python
--   b.diagnostics.ruff,
--   b.formatting.autopep8,
--   -- Go
--   b.formatting.gofmt,
--   b.diagnostics.golangci_lint.with {
--     extra_args = { "--path-prefix", vim.fn.getcwd() }, -- Explicitly set the working directory
--     cwd = vim.fn.getcwd(), -- Restrict linter to current working directory
--
--   },
-- }
--
-- null_ls.setup {
--   debug = true,
--   sources = sources,
--   log = {
--     enable = true,
--     level = "warn",
--   },
-- }

local null_ls = require "null-ls"

local sources = {
  -- Ruff diagnostics (ignore import sorting)
  require("none-ls.diagnostics.ruff").with {
    extra_args = {
      "--config",
      "lint.ignore = ['I']",
      "--config",
      "preview = true",
    },
  },
  -- Ruff formatting (line length + quote style)
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

  -- Optional formatters
  null_ls.builtins.formatting.prettier.with {
    filetypes = { "json", "yaml", "markdown", "html", "css", "python", "lua", "typescript" },
    extra_args = {
      "--single-quote",
      "--tab-width",
      "4",
      "--use-tabs",
      "false",
    },
  },
  null_ls.builtins.formatting.stylua,
  null_ls.builtins.formatting.shfmt.with {
    args = { "-i", "4" },
  },
}

null_ls.setup {
  sources = sources,
}
