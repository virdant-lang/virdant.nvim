local M = {}

--- Maps tree-sitter highlight groups to Virdant colors from
--- https://virdant.org/_static/virdant-syntax.css
local HIGHLIGHTS = {
  -- Keywords (.k → dark olive green)
  ["@keyword"]              = { fg = "#556B2F" },
  -- Comments (.c1, .cm → muted grey-green, italic)
  ["@comment"]              = { fg = "#756B61", italic = true },
  -- Operators (.p → brown)
  ["@operator"]             = { fg = "#8B6E47" },
  -- Punctuation (.p → brown)
  ["@punctuation.bracket"]  = { fg = "#8B6E47" },
  ["@punctuation.delimiter"] = { fg = "#8B6E47" },
  ["@punctuation.special"]  = { fg = "#C65D3B" },
  -- Special "it" keyword (.kp → reddish brown, bold)
  ["@variable.builtin"]     = { fg = "#AE604F", bold = true },
  -- Variables (.nv → reddish brown)
  ["@variable"]             = { fg = "#AE604F" },
  ["@variable.parameter"]   = { fg = "#AE604F" },
  ["@variable.member"]      = { fg = "#AE604F" },
  -- Types (.nc → rust/terracotta)
  ["@type"]                 = { fg = "#B83A34" },
  -- Built-in types (.nb → deep red)
  ["@type.builtin"]         = { fg = "#B83A34" },
  -- Constants / enum variants (.no → burnt orange)
  ["@constant"]             = { fg = "#C65D3B" },
  -- Numbers (.mi → burnt orange)
  ["@number"]               = { fg = "#C65D3B" },
  -- Booleans (.kc → burnt orange)
  ["@boolean"]              = { fg = "#C65D3B" },
  -- Constructors (.nd → burnt orange)
  ["@constructor"]          = { fg = "#C65D3B" },
  -- Strings
  ["@string"]               = { fg = "#AE604F" },
  -- Functions
  ["@function"]             = { fg = "#AE604F" },
}

local merged

--- Apply Virdant highlights for the virdant filetype.
--- Called from a FileType autocommand so highlights are only set on virdant buffers.
function M.apply()
  merged = merged or HIGHLIGHTS
  for group, attrs in pairs(merged) do
    vim.api.nvim_set_hl(0, group, attrs)
  end
end

--- Accept user overrides and register the filetype autocommand.
---@param opts table|nil
function M.setup(opts)
  opts = opts or {}
  merged = vim.tbl_deep_extend("keep", opts.highlights or {}, HIGHLIGHTS)

  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("virdant-highlights", { clear = true }),
    pattern = "virdant",
    callback = function()
      M.apply()
    end,
  })
end

return M