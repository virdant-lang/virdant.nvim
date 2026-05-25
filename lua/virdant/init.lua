local highlights = require('virdant.highlights')

local M = {}

function M.setup(opts)
  opts = opts or {}

  -- Filetype detection for .vir files
  vim.filetype.add({
    extension = { vir = 'virdant' },
  })

  -- LSP client registration for vir-lsp
  vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('virdant-lsp', { clear = true }),
    pattern = 'virdant',
    callback = function()
      local lspconfig = require('lspconfig')
      local configs = require('lspconfig.configs')

      if not configs['vir-lsp'] then
        configs['vir-lsp'] = {
          default_config = {
            cmd = opts.lsp_cmd or { 'vir-lsp' },
            filetypes = { 'virdant' },
            root_dir = lspconfig.util.root_pattern('.git', 'Virdant.toml'),
            name = 'vir-lsp',
          },
        }
      end

      lspconfig['vir-lsp'].setup({})
    end,
  })

  -- Tree-sitter: register the language name.
  -- Neovim will find parser/virdant.so on the runtimepath
  -- (e.g. ~/.config/nvim/parser/virdant.so, or a plugin's parser/ dir)
  -- automatically. No need for manual loading.
  vim.treesitter.language.register('virdant', 'virdant')

  -- Apply Virdant-specific highlight colors
  highlights.setup(opts)
end

return M
