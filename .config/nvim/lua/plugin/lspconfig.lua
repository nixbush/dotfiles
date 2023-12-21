local spec = {
   'neovim/nvim-lspconfig',
   ft = { 'c', 'cpp', 'lua', 'racket', 'scheme' },
}

---------------------------------
-- LSP Configuration
---------------------------------
-- default configuration for every language server
-- (just dump 'lsp' to get defaults)
local lsp = {}
lsp.capabilities = require('cmp_nvim_lsp').default_capabilities()
lsp.capabilities.textDocument.foldingRange = {
   dynamicRegistration = false,
   lineFoldingOnly = true,
}

lsp.handlers = {
   ['textDocument/hover'] = vim.lsp.with(
      vim.lsp.handlers.hover,
      { border = 'single' }
   ),
   ['textDocument/publishDiagnostics'] = vim.lsp.with(
      vim.lsp.diagnostic.on_publish_diagnostics,
      { severity_sort = true }
   ),
   ['textDocument/signatureHelp'] = vim.lsp.with(
      vim.lsp.handlers.signature_help,
      { border = 'single' }
   ),
}

lsp.on_attach = function(_, bufnr)
   -- Set mappings
   local map = function(mode, key, cmd, opts)
      opts.buffer = bufnr
      vim.keymap.set(mode, key, cmd, opts)
   end

   map(
      'n',
      '<leader>lD',
      vim.lsp.buf.declaration,
      { desc = 'Goto declaration' }
   )
   map('n', '<leader>ld', vim.lsp.buf.definition, { desc = 'Goto definition' })
   map('n', '<leader>lh', vim.lsp.buf.hover, { desc = 'Open hover window' })
   map(
      'n',
      '<leader>li',
      vim.lsp.buf.implementation,
      { desc = 'Goto implementation' }
   )
   map(
      'n',
      '<leader>ls',
      vim.lsp.buf.signature_help,
      { desc = 'Open signature help' }
   )
   map(
      'n',
      '<leader>lt',
      vim.lsp.buf.type_definition,
      { desc = 'Goto type definition' }
   )
   map('n', '<leader>lr', vim.lsp.buf.rename, { desc = 'Rename under cursor' })
   map(
      'n',
      '<leader>la',
      vim.lsp.buf.code_action,
      { desc = 'Open code actions' }
   )
   map('n', '<leader>lq', vim.lsp.buf.references, { desc = 'List references' })
   map('n', '<leader>lf', function ()
      vim.lsp.buf.format {
         timeout_ms = 10000,
      }
   end, { desc = 'Format buffer' })
   map(
      'n',
      '<leader>le',
      vim.diagnostic.open_float,
      { desc = 'Open diagnostic window' }
   )
   map(
      'n',
      '<leader>ll',
      vim.diagnostic.setloclist,
      { desc = 'Open diagnostic loclist' }
   )
   map(
      'n',
      '<leader>lL',
      vim.diagnostic.setqflist,
      { desc = 'Open diagnostic quickfix' }
   )
   map('n', '[e', vim.diagnostic.goto_prev, { desc = 'Goto prev diagnostic' })
   map('n', ']e', vim.diagnostic.goto_next, { desc = 'Goto next diagnostic' })
end

---------------------------------
-- LSP Setup
---------------------------------
spec.init = function()
   -- Change diagnostic signs
   local signs = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }
   for type, icon in pairs(signs) do
      local hl = 'DiagnosticSign' .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
   end

   -- change diagnostic config
   vim.diagnostic.config {
      virtual_text = {
         source = 'always',
         prefix = '󰧞',
      },
      float = {
         focusable = false,
         close_events = {
            'bufleave',
            'cursormoved',
            'insertenter',
            'focuslost',
         },
         border = 'single',
         source = 'always',
         prefix = ' ',
         scope = 'line', -- cursor
      },
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
   }
end

spec.config = function()
   local lspconfig = require 'lspconfig'
   lspconfig.lua_ls.setup {
      handlers = lsp.handlers,
      on_attach = lsp.on_attach,
      capabilities = lsp.capabilities,
      settings = {
         Lua = {
            runtime = {
               version = 'LuaJIT',
            },
            diagnostics = {
               globals = { 'vim' },
            },
            workspace = {
               library = vim.env.VIspecRUNTIME,
            },
            telemetry = {
               enable = false,
            },
         },
      },
   }

   lspconfig.clangd.setup {
      handlers = lsp.handlers,
      on_attach = function(client, bufnr)
         lsp.on_attach(client, bufnr)
         vim.keymap.set(
            'n',
            'gs',
            '<cmd>ClangdSwitchSourceHeader<cr>',
            { buffer = bufnr }
         )
      end,
      capabilities = lsp.capabilities,
      cmd = {
         '/usr/bin/clangd',
         '--background-index',
         '--compile-commands-dir=build/',
         '--header-insertion-decorators=0',
         '--header-insertion=never',
         '--offset-encoding=utf-16',
         '--malloc-trim',
      },
   }

   lspconfig.racket_langserver.setup {
      handlers = lsp.handlers,
      on_attach = lsp.on_attach,
      capabilities = lsp.capabilities,
      root_dir = function()
         return vim.fn.getcwd()
      end,
   }
end

return spec
