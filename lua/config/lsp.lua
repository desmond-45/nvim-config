vim.diagnostic.config {
  virtual_text = {
    prefix = "",
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if ok_cmp then
  capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

local function on_attach(client, bufnr)
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false
end

-- Keep pyright for completion / hover / goto; ruff owns inline lint.
-- Neovim 0.12 opens multiple pyright diagnostic namespaces (push/pull),
-- so clear by source name whenever diagnostics change.
local clearing_pyright = false
vim.api.nvim_create_autocmd("DiagnosticChanged", {
  group = vim.api.nvim_create_augroup("ConfigLspNoPyrightDiags", { clear = true }),
  callback = function(args)
    if clearing_pyright then
      return
    end
    local bufnr = args.buf
    local namespaces = {}
    for _, diagnostic in ipairs(vim.diagnostic.get(bufnr)) do
      local source = diagnostic.source or ""
      if source:lower() == "pyright" and diagnostic.namespace then
        namespaces[diagnostic.namespace] = true
      end
    end
    if vim.tbl_isempty(namespaces) then
      return
    end
    clearing_pyright = true
    for ns in pairs(namespaces) do
      vim.diagnostic.enable(false, { ns_id = ns })
      vim.diagnostic.reset(ns, bufnr)
    end
    clearing_pyright = false
  end,
})

local function setup_lsp(name, opts)
  vim.lsp.config(
    name,
    vim.tbl_extend("force", {
      on_attach = on_attach,
      capabilities = capabilities,
    }, opts or {})
  )
  vim.lsp.enable(name)
end

for _, lsp in ipairs { "html", "cssls", "clangd" } do
  setup_lsp(lsp)
end

setup_lsp("lua_ls", {
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
        },
      },
      telemetry = {
        enable = false,
      },
    },
  },
})

setup_lsp("ts_ls", {
  filetypes = {
    "typescript",
    "javascript",
    "typescriptreact",
    "javascriptreact",
  },
  root_markers = {
    "package.json",
    "tsconfig.json",
    "jsconfig.json",
    ".git",
  },
})

local function resolve_python_path(root_dir)
  if vim.env.VIRTUAL_ENV and vim.env.VIRTUAL_ENV ~= "" then
    local activated = vim.env.VIRTUAL_ENV .. "/bin/python"
    if vim.fn.executable(activated) == 1 then
      return activated
    end
  end

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
        autoImportCompletions = true,
        diagnosticMode = "openFilesOnly",
        typeCheckingMode = "off",
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
