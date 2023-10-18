local M = {
   'neovim/nvim-lspconfig',
   dependencies = { 'nvimdev/guard.nvim' },
   ft = { 'c', 'cpp', 'lua' },
}

---------------------------------
-- LSP Setup
---------------------------------
M.init = function()
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

local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.textDocument.foldingRange = {
   dynamicRegistration = false,
   lineFoldingOnly = true,
}

local handlers = {
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

local on_attach = function(_, bufnr)
   -- Set mappings
   local wk = require 'which-key'
   wk.register {
      ['<leader>l'] = {
         name = 'LSP Actions',
         D = 'Goto declaration',
         d = 'Goto definition',
         h = 'Open Hover window',
         i = 'Goto implementation',
         s = 'Open signature help',
         t = 'Goto type definition',
         r = 'Rename under cursor',
         a = 'Open code actions',
         q = 'List references',
         e = 'Open diagnostic window',
         l = 'Open diagnostic loclist',
         L = 'Open diagnostic quickfix',
         f = 'Format selected',
      },
      ['[e'] = 'Goto prev diagnostic',
      [']e'] = 'Goto next diagnostic',
   }

   local map = function(mode, key, cmd)
      vim.keymap.set(mode, key, cmd, { buffer = bufnr })
   end
   map('n', '<leader>lD', vim.lsp.buf.declaration)
   map('n', '<leader>ld', vim.lsp.buf.definition)
   map('n', '<leader>lh', vim.lsp.buf.hover)
   map('n', '<leader>li', vim.lsp.buf.implementation)
   map('n', '<leader>ls', vim.lsp.buf.signature_help)
   map('n', '<leader>lt', vim.lsp.buf.type_definition)
   map('n', '<leader>lr', vim.lsp.buf.rename)
   map('n', '<leader>la', vim.lsp.buf.code_action)
   map('n', '<leader>lq', vim.lsp.buf.references)
   map('n', '<leader>le', vim.diagnostic.open_float)
   map('n', '<leader>ll', vim.diagnostic.setloclist)
   map('n', '<leader>lL', vim.diagnostic.setqflist)
   map('n', '[e', vim.diagnostic.goto_prev)
   map('n', ']e', vim.diagnostic.goto_next)
   map('n', '<leader>lf', function()
      vim.lsp.buf.format { bufnr = 0, timeout_ms = 5000 }
   end)
end

---------------------------------
-- LSP Config
---------------------------------
M.config = function()
   local lspconfig = require 'lspconfig'

   lspconfig.lua_ls.setup {
      capabilities = capabilities,
      on_attach = on_attach,
      handlers = handlers,
      settings = {
         Lua = {
            runtime = {
               version = 'LuaJIT',
            },
            diagnostics = {
               globals = { 'vim' },
            },
            workspace = {
               library = vim.env.VIMRUNTIME,
            },
            telemetry = {
               enable = false,
            },
         },
      },
   }

   lspconfig.clangd.setup {
      capabilities = capabilities,
      on_attach = function(client, bufnr)
         on_attach(client, bufnr)
         vim.keymap.set(
            'n',
            'gs',
            '<cmd>ClangdSwitchSourceHeader<cr>',
            { buffer = bufnr }
         )
      end,
      handlers = handlers,
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
end

return M
