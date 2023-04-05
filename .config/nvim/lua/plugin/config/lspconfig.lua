local M = {}

M.config = function()
   ---------------------------------
   -- LSP UI customization
   ---------------------------------
   -- Change diagnostic signs
   local signs = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }
   for type, icon in pairs(signs) do
      local hl = 'DiagnosticSign' .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
   end

   -- Change diagnostic config
   vim.diagnostic.config {
      virtual_text = {
         source = 'always',
         prefix = '●',
      },
      float = {
         focusable = false,
         close_events = {
            'BufLeave',
            'CursorMoved',
            'InsertEnter',
            'FocusLost',
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

   ---------------------------------
   -- LSP Attachments
   ---------------------------------
   local common_capabilities = require('cmp_nvim_lsp').default_capabilities()
   common_capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
   }

   local common_handlers = {
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

   local common_on_attach = function(_, bufnr)
      -- Let a formatter plugin handle it
      -- client.server_capabilities.documentFormattingProvider = false
      -- client.server_capabilities.documentRangeFormattingProvider = false

      -- Set mappings
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
      map('n', '<leader>lf', vim.lsp.buf.format)
      map({ 'n', 'v', 'x' }, '<leader>lF', require('utils').range_format)
      map('n', '<leader>le', vim.diagnostic.open_float)
      map('n', '<leader>ll', vim.diagnostic.setloclist)
      map('n', '<leader>lL', vim.diagnostic.setqflist)
      map('n', '[e', vim.diagnostic.goto_prev)
      map('n', ']e', vim.diagnostic.goto_next)
   end

   ---------------------------------
   -- LSP Configuration
   ---------------------------------
   local lspconfig = require 'lspconfig'

   lspconfig.lua_ls.setup {
      on_attach = common_on_attach,
      handlers = common_handlers,
      capabilities = common_capabilities,
      settings = {
         Lua = {
            runtime = {
               version = 'LuaJIT',
            },
            diagnostics = {
               globals = { 'vim' },
            },
            workspace = {
               library = vim.api.nvim_get_runtime_file('', true),
            },
            telemetry = {
               enable = false,
            },
         },
      },
   }

   lspconfig.clangd.setup {
      capabilities = common_capabilities,
      on_attach = function(client, bufnr)
         common_on_attach(client, bufnr)
         vim.keymap.set(
            'n',
            'gs',
            '<cmd>ClangdSwitchSourceHeader<cr>',
            { buffer = bufnr }
         )
      end,
      handlers = common_handlers,
      cmd = {
         '/usr/bin/clangd',
         '--background-index',
         '--compile-commands-dir=build/',
         '--header-insertion-decorators=0',
         '--header-insertion=never',
      },
   }

   lspconfig.rust_analyzer.setup {
      on_attach = common_on_attach,
      handlers = common_handlers,
      capabilities = common_capabilities,
      cmd = {
         '/usr/bin/rustup',
         'run',
         'stable',
         'rust-analyzer',
      },
      settings = {
         ['rust-analyzer'] = {
            checkOnSave = {
               command = 'clippy',
            },
            imports = {
               granularity = {
                  group = 'module',
               },
               prefix = 'self',
            },
            cargo = {
               buildScripts = {
                  enable = true,
               },
            },
            procMacro = {
               enable = true,
            },
         },
      },
   }
end

---------------------------------
return M
