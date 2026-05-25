# virdant.nvim

A [Neovim](https://neovim.io) plugin for the [Virdant](https://virdant.org) hardware description language.  
Provides syntax highlighting via Tree-sitter, LSP client integration for `vir-lsp`, and automatic filetype detection for `.vir` files.

## Features

- **Filetype detection** – `.vir` files are automatically recognised as `virdant`.
- **Tree-sitter syntax highlighting** – Comprehensive highlight queries covering keywords, types, operators, comments, strings, constants, variables, functions, and more. Colours are drawn from the official [Virdant syntax stylesheet](https://virdant.org/_static/virdant-syntax.css).
- **LSP integration** – Registers the `vir-lsp` language server for the `virdant` filetype (requires the `vir-lsp` binary to be installed separately).
- **Customisable colours** – Highlight groups can be overridden via `setup()` options.

## Requirements

- Neovim >= 0.9 (the builtin vim.filetype.add and vim.treesitter.language.register APIs were added in 0.9)
- A compiled Tree-sitter parser for the `virdant` language (e.g. `parser/virdant.so` on your runtimepath)
- (Optional) `vir-lsp` – the Virdant language server, for LSP features

## Installation

### Neovim 0.12 builtin package manager

Neovim 0.12 ships with a builtin package manager via `vim.loader` and `:Import`. The simplest way to install `virdant.nvim` is to clone the repository into your `pack` directory:

```bash
# Create the opt directory if it doesn't already exist
mkdir -p ~/.config/nvim/pack/virdant/opt

# Clone the plugin
git clone https://github.com/virdant-lang/virdant.nvim ~/.config/nvim/pack/virdant/opt/virdant.nvim
```

Then add the following to your `init.lua` to load and configure it:

```lua
-- Load the plugin
vim.cmd('packadd virdant.nvim')

-- Optional: configure with custom options
require('virdant').setup({
  -- Path to the vir-lsp binary (default: 'vir-lsp')
  lsp_cmd = { 'vir-lsp' },
  -- Override highlight groups
  highlights = {
    ["@keyword"] = { fg = "#556B2F" },
  },
})
```

> **Tip:** If you want it loaded automatically on startup without `packadd`, clone into `pack/virdant/start` instead:
> ```bash
> git clone https://github.com/virdant-lang/virdant.nvim ~/.config/nvim/pack/virdant/start/virdant.nvim
> ```

### lazy.nvim

```lua
{
  'virdant-lang/virdant.nvim',
  opts = {
    lsp_cmd = { 'vir-lsp' },
  },
}
```

### rocks.nvim

```lua
:Rocks install virdant.nvim
```

## Configuration

Call `require('virdant').setup(opts)` with an optional table:

| Option        | Type     | Default      | Description                                         |
|---------------|----------|--------------|-----------------------------------------------------|
| `lsp_cmd`     | `table`  | `{'vir-lsp'}`| Command and arguments to start the Virdant LSP.     |
| `highlights`  | `table`  | `{}`         | Override or extend the built-in highlight groups.   |

### Available highlight groups

| Highlight group             | Default colour | Description                     |
|-----------------------------|----------------|---------------------------------|
| `@keyword`                  | `#556B2F`      | Keywords (`enum`, `fn`, etc.)   |
| `@comment`                  | `#9CA892`      | Line and block comments         |
| `@operator`                 | `#8B6E47`      | Operators (`:=`, `<=`, etc.)    |
| `@punctuation.bracket`      | `#8B6E47`      | Brackets `() {} []`             |
| `@punctuation.delimiter`    | `#8B6E47`      | Delimiters `,` `:` `.` `::`     |
| `@punctuation.special`      | `#C65D3B`      | `#` prefix                      |
| `@variable.builtin`         | `#AE604F`      | `it` keyword (bold)             |
| `@variable`                 | `#AE604F`      | General identifiers             |
| `@variable.parameter`       | `#AE604F`      | Function parameters             |
| `@variable.member`          | `#AE604F`      | Struct member fields            |
| `@type`                     | `#B8851A`      | Type names                      |
| `@type.builtin`             | `#B8851A`      | Built-in types (`Bit`, `Word`)  |
| `@constant`                 | `#C65D3B`      | Enum variant names / constants  |
| `@number`                   | `#C65D3B`      | Numeric literals                |
| `@boolean`                  | `#C65D3B`      | `true`, `false`, `dontcare`     |
| `@constructor`              | `#C65D3B`      | Union constructors              |
| `@string`                   | `#AE604F`      | String literals                 |
| `@function`                 | `#AE604F`      | Function definitions            |

## Tree-sitter parser

For syntax highlighting to work, you need a Tree-sitter parser for the `virdant` language compiled to `parser/virdant.so` somewhere on your runtimepath (e.g. in the same plugin directory or under `~/.config/nvim/parser/`).

If the parser is available as a Neovim plugin (e.g. `tree-sitter-virdant`), install it via your package manager and the plugin will register the language automatically.

## File structure

```
virdant.nvim/
├── plugin/
│   └── virdant.lua           # Entry point; calls setup() on load
├── lua/
│   └── virdant/
│       ├── init.lua           # Core plugin logic (filetype, LSP, treesitter)
│       └── highlights.lua     # Highlight group definitions
├── queries/
│   └── virdant/
│       └── highlights.scm     # Tree-sitter highlight queries
└── README.md
```

## License

MIT
