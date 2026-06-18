-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  -- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- Built in lsp
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  -- buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<leader>k', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<leader>s', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  -- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  -- buf_set_keymap('n', '<space>d', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', 'g[', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', 'g]', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  -- buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  -- buf_set_keymap('n', 'ff', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  buf_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '<leader>ff', '<cmd>lua vim.lsp.buf.format { async = true }<CR>', opts)

  -- FORMAT ON SAVE

--  vim.api.nvim_exec([[
--  augroup FormatAutogroup
--    autocmd!
--    autocmd BufWritePost *.js,*.jsx,*.ts,*.tsx,*.json FormatWrite
--  augroup END
--  ]], true)

-- BORDERS

  vim.diagnostic.config{
    float={border = 'single'}
  }

  vim.cmd [[autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335]]
  vim.cmd [[autocmd! ColorScheme * highlight FloatBorder guifg=white]]

  local hover = vim.lsp.buf.hover
  vim.lsp.buf.hover = function()
      return hover { border = 'single' }
  end

  local signature_help = vim.lsp.buf.signature_help
  vim.lsp.buf.signature_help = function()
      return signature_help { border = 'single' }
  end
end

-- COMPLETION

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- SERVERS SETUP

local servers = {
  'pyright',
  'rust_analyzer',
  'ts_ls',
  'jsonls',
  'html',
  'cssls',
  'eslint',
  'dartls',
  'tailwindcss',
  'prismals',
  'marksman',
  'graphql',
  "clangd",
  "lua_ls",
}

for _, lsp in ipairs(servers) do
  vim.lsp.config(lsp, {
    on_attach = on_attach,
    capabilities = capabilities,
    handlers = handlers,
  })
  vim.lsp.enable(lsp)
end
