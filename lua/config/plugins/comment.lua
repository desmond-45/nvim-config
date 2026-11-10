return {
  "numToStr/Comment.nvim",
  config = function()
    require("Comment").setup {
      pre_hook = function()
        local cstr = vim.bo.commentstring
        if cstr ~= nil and cstr ~= "" then
          return cstr
        end
      end,
    }
  end,
}
