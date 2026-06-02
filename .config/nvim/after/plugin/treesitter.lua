local ts = require('nvim-treesitter')

local parsers = {
  "tsx",
  "toml",
  "php",
  "json",
  "yaml",
  "html",
  "scss",
  "css",
  "dart",
  "python",
  "typescript",
  "javascript",
  "rust",
  "lua",
  "vim",
  "prisma",
  "markdown",
  "markdown_inline",
}

-- Install missing parsers only
local installed = ts.get_installed("parsers")
local to_install = vim.tbl_filter(function(p)
  return not vim.tbl_contains(installed, p)
end, parsers)

if #to_install > 0 then
  ts.install(to_install)
end

-- Collect filetypes for all parsers (parser name != filetype always)
local patterns = {}
for _, parser in ipairs(parsers) do
  local fts = vim.treesitter.language.get_filetypes(parser)
  for _, ft in ipairs(fts) do
    table.insert(patterns, ft)
  end
end

-- Enable highlighting on those filetypes
vim.api.nvim_create_autocmd('FileType', {
  pattern = patterns,
  callback = function()
    vim.treesitter.start()
    -- Optional: folding via treesitter
    -- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    -- vim.wo.foldmethod = 'expr'
    -- Optional: indent (experimental)
    -- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})

