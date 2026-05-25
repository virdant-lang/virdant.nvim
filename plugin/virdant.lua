if vim.g.virdant_loaded then
  return
end
vim.g.virdant_loaded = true

require('virdant').setup()
