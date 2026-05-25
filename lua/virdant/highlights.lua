local M = {}

--- Maps tree-sitter highlight groups to Virdant colors from
--- https://virdant.org/_static/virdant-syntax.css
local HIGHLIGHTS = {
  -- Keywords (.k → dark olive green)
  ["@keyword"]              = { fg = "#556B2F" },
  -- Comments (.c1, .cm → gray-green, italic)
  ["@comment"]              = { fg = "#9B9E98", italic = true },
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
  -- Types (.nc → golden brown)
  ["@type"]                 = { fg = "#B8851A" },
  -- Built-in types (.nb → golden brown)
  ["@type.builtin"]         = { fg = "#B8851A" },
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

function M.setup(opts)
  opts = opts or {}
  local colors = vim.tbl_deep_extend("keep", opts.highlights or {}, HIGHLIGHTS)

  for group, attrs in pairs(colors) do
    vim.api.nvim_set_hl(0, group, attrs)
  end
end

return M
