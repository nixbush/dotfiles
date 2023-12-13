---------------------------------
-- Helpers
---------------------------------
local has_words_before = function()
   unpack = unpack or table.unpack
   local line, col = unpack(vim.api.nvim_win_get_cursor(0))
   return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

---------------------------------
-- nvim-cmp configuration
---------------------------------
local spec = {
   'hrsh7th/nvim-cmp',
   dependencies = {
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      { 'saadparwaiz1/cmp_luasnip', dependencies = { "L3MON4D3/LuaSnip" } },
   },
   event = 'InsertEnter',
}

spec.config = function()
   local cmp = require 'cmp'
   local luasnip = require 'luasnip'
   cmp.setup {
      snippet = {
         expand = function(args)
            require("luasnip").lsp_expand(args.body)
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
               luasnip = 'Snippet',
            })[entry.source.name]
            local label = vim_item.abbr
            local truncated_label = vim.fn.strcharpart(label, 0, 30)
            if truncated_label ~= label then
               vim_item.abbr = truncated_label .. '…'
            end
            return vim_item
         end,
      },
      sorting = {
         comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            function(entry1, entry2)
               local _, entry1_under = entry1.completion_item.label:find "^_+"
               local _, entry2_under = entry2.completion_item.label:find "^_+"
               entry1_under = entry1_under or 0
               entry2_under = entry2_under or 0
               if entry1_under > entry2_under then
                  return false
               elseif entry1_under < entry2_under then
                  return true
               end
            end,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
         },
      },
      mapping = cmp.mapping.preset.insert {
         ['<C-b>'] = cmp.mapping.scroll_docs(-1),
         ['<C-f>'] = cmp.mapping.scroll_docs(1),
         ['<C-Space>'] = cmp.mapping.complete(),
         ['<C-e>'] = cmp.mapping.abort(),
         ['<CR>'] = cmp.mapping.confirm { select = false },
         ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
               cmp.select_next_item()
               -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
               -- that way you will only jump inside the snippet region
            elseif luasnip.expand_or_locally_jumpable() then
               luasnip.expand_or_jump()
            elseif has_words_before() then
               cmp.complete()
            else
               fallback()
            end
         end, { "i", "s" }),
         ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
               cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
               luasnip.jump(-1)
            else
               fallback()
            end
         end, { "i", "s" }),
      },
      sources = {
         { name = 'path' },
         { name = 'buffer' },
         { name = 'nvim_lsp' },
         { name = 'nvim_lsp_signature_help' },
         { name = "luasnip" },
      },
   }
end

return spec
