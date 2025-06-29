local M = {}

M.override = {
  Comment = {
    italic = false,
  },
  -- Active buffer tab
  TbLineBufOn = {
    fg = "#ffffff",
    bg = "#222222",
    bold = true,
  },
  -- Inactive buffer tabs
  TbLineBufOff = {
    fg = "#bbbbbb",
    bg = "#000000",
  },
  -- Active buffer close button
  TbLineBufOnClose = {
    fg = "#ffffff",
    bg = "#222222",
  },
  -- Inactive buffer close button
  TbLineBufOffClose = {
    fg = "#bbbbbb",
    bg = "#000000",
  },
  -- Active modified buffer
  TbLineBufOnModified = {
    fg = "#17fe04",
    bg = "#000000",
  },
  -- Inactive modified buffer
  TbLineBufOffModified = {
    fg = "#17fe04",
    bg = "#000000",
  },
  -- Inactive tab page
  TbLineTabOff = {
    fg = "#bbbbbb",
    bg = "#30343f",
  },
  TblineFill = {
    bg = "#000000",
  },
}

---@type HLTable
M.add = {
  NvimTreeOpenedFolderName = { fg = "green", bold = true },
}

return M
