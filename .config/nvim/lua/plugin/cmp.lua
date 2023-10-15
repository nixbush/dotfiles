return {
   'hrsh7th/nvim-cmp',
   dependencies = {
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'dcampos/cmp-snippy',
      'dcampos/nvim-snippy',
   },
   config = function()
      local cmp = require 'cmp'
      cmp.setup {
         snippet = {
            expand = function(args)
               require('snippy').expand_snippet(args.body)
            end,
         },
         formatting = {
            format = function(entry, vim_item)
               local icons = {
                  Text = '',
                  Method = '',
                  Function = '',
                  Constructor = '',
                  Field = '',
                  Variable = '',
                  Class = '',
                  Interface = '',
                  Module = '',
                  Property = '',
                  Unit = '',
                  Value = '',
                  Enum = '',
                  Keyword = '',
                  Snippet = '',
                  Color = '',
                  File = '',
                  Reference = '',
                  Folder = '',
                  EnumMember = '',
                  Constant = '',
                  Struct = '',
                  Event = '',
                  Operator = '',
                  TypeParameter = '',
               }

               vim_item.kind = icons[vim_item.kind] .. '  ' .. vim_item.kind
               vim_item.menu = ({
                  nvim_lsp = 'LSP',
                  buffer = 'Buffer',
                  path = 'Path',
                  nvim_lsp_signature_help = 'Argument',
                  snippy = 'Snippy',
               })[entry.source.name]

               local label = vim_item.abbr
               local truncated_label = vim.fn.strcharpart(label, 0, 30)
               if truncated_label ~= label then
                  vim_item.abbr = truncated_label .. '…'
               end

               return vim_item
            end,
         },
         mapping = cmp.mapping.preset.insert {
            ['<C-b>'] = cmp.mapping.scroll_docs(-1),
            ['<C-f>'] = cmp.mapping.scroll_docs(1),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm { select = false },
            ['<Tab>'] = cmp.mapping.select_next_item(),
            ['<S-Tab>'] = cmp.mapping.select_prev_item(),
         },
         sources = {
            { name = 'nvim_lsp' },
            { name = 'buffer' },
            { name = 'path' },
            { name = 'nvim_lsp_signature_help' },
            { name = 'snippy' },
         },
      }
   end,
   event = 'InsertEnter',
}
