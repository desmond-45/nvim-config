local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local function setup_lsp(name, opts)
  vim.lsp.config(name, vim.tbl_extend("force", {
    on_attach = on_attach,
    capabilities = capabilities,
  }, opts or {}))
  vim.lsp.enable(name)
end

local servers = { "html", "cssls", "clangd" }

for _, lsp in ipairs(servers) do
  setup_lsp(lsp)
end

setup_lsp("ts_ls", {
  filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
  root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
  },
})

local function resolve_python_path(root_dir)
  -- Prefer the shell-activated virtualenv when nvim was started from it.
  if vim.env.VIRTUAL_ENV and vim.env.VIRTUAL_ENV ~= "" then
    local activated = vim.env.VIRTUAL_ENV .. "/bin/python"
    if vim.fn.executable(activated) == 1 then
      return activated
    end
  end

  -- Else prefer a project-local virtualenv.
  root_dir = root_dir or vim.fn.getcwd()
  for _, name in ipairs { ".venv", "venv" } do
    local candidate = root_dir .. "/" .. name .. "/bin/python"
    if vim.fn.executable(candidate) == 1 then
      return candidate
    end
  end

  return vim.fn.exepath "python3" or vim.fn.exepath "python" or "python3"
end

setup_lsp("pyright", {
  filetypes = { "python" },
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
      },
    },
  },
  before_init = function(_, config)
    local root = config.root_dir or vim.fn.getcwd()
    config.settings = config.settings or {}
    config.settings.python = config.settings.python or {}
    config.settings.python.pythonPath = resolve_python_path(root)
  end,
})

setup_lsp("gopls", {
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_markers = { "go.work", "go.mod", ".git" },
  settings = {
    gopls = {
      completeUnimported = true,
      analyses = {
        unusedparams = true,
      },
    },
  },
})
