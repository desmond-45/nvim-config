local M = {}

local function lsp_symbol(name, icon)
  local hl = "DiagnosticSign" .. name
  vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
end

lsp_symbol("Error", "󰅙")
lsp_symbol("Info", "󰋼")
lsp_symbol("Hint", "󰌵")
lsp_symbol("Warn", "")

vim.diagnostic.config {
  virtual_text = {
    prefix = "",
  },
  signs = true,
  underline = true,
  update_in_insert = false,
}

local function with_border(handler, opts)
  return function(err, result, ctx, config)
    config = vim.tbl_deep_extend("force", config or {}, opts)
    return handler(err, result, ctx, config)
  end
end

vim.lsp.handlers["textDocument/hover"] = with_border(vim.lsp.handlers.hover, {
  border = "single",
})
vim.lsp.handlers["textDocument/signatureHelp"] = with_border(
  vim.lsp.handlers.signature_help,
  {
    border = "single",
    focusable = false,
    relative = "cursor",
  }
)

return M
