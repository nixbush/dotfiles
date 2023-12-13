local spec = {
   'willothy/nvim-cokeline',
   event = 'VeryLazy',
   keys = {
      { 'H', '<Plug>(cokeline-focus-prev)' },
      { 'L', '<Plug>(cokeline-focus-next)' },
      { '<C-c>', '<Plug>(cokeline-pick-focus)' },
      { '<C-u>', '<Plug>(cokeline-switch-prev)' },
      { '<C-i>', '<Plug>(cokeline-switch-next)' },
   },
}

spec.config = function ()
   ---------------------------------
   -- Set global options
   ---------------------------------
   local colors = require('catppuccin.palettes').get_palette 'macchiato'
   local hlgroups = require 'cokeline.hlgroups'
   local mappings = require 'cokeline.mappings'
   local min_buf_width = 20

   local mode_colors = {
      n = colors.blue,
      i = colors.green,
      v = colors.yellow,
      V = colors.yellow,
      ['\22'] = colors.yellow,
      c = colors.mauve,
      s = colors.peach,
      S = colors.peach,
      ['\19'] = colors.peach,
      R = colors.red,
      r = colors.lavender,
      ['!'] = colors.red,
      t = colors.red,
   }

   ---------------------------------
   -- Components
   ---------------------------------
   local get_remaining_space = function(buffer, parts)
      local used_space = 0
      for _, p in pairs(parts) do
         used_space = used_space
            + vim.fn.strwidth(
               (type(p.text) == 'string' and p.text)
                  or (type(p.text) == 'function' and p.text(buffer))
            )
      end
      return math.max(0, min_buf_width - used_space)
   end

   local parts = {
      buf = {
         space = {
            text = function()
               return ' '
            end,
            truncation = { priority = 1 },
         },
         icon = {
            text = function(buf)
               return (
                  mappings.is_picking_focus()
                  or mappings.is_picking_close()
               )
                     and buf.pick_letter
                  or buf.devicon.icon
            end,
            bold = true,
            underline = function()
               return mappings.is_picking_focus() or mappings.is_picking_close()
            end,
            truncation = { priority = 1 },
         },
         prefix = {
            text = function(buf)
               return buf.unique_prefix
            end,
            style = 'italic',
            truncation = { priority = 3, direction = 'left' },
         },
         name = {
            text = function(buf)
               return buf.filename
            end,
            truncation = { priority = 2, direction = 'left' },
         },
         modifier = {
            text = function(buf)
               return buf.is_modified and '' or '󰅖'
            end,
            delete_buffer_on_left_click = true,
            truncation = { priority = 1 },
         },
      },
      tab = {
         space = {
            text = function()
               return '  '
            end,
            truncation = { priority = 1 },
            bg = function(buf)
               return buf.is_active and mode_colors[vim.fn.mode()]
                  or colors.surface0
            end,
         },
         index = {
            text = function(tab)
               return tab.number
            end,
            truncation = { priority = 1 },
            fg = function(tab)
               return tab.is_active
                     and hlgroups.get_hl_attr('ColorColumn', 'bg')
                  or hlgroups.get_hl_attr('Normal', 'fg')
            end,
            bg = function(buf)
               return buf.is_active and mode_colors[vim.fn.mode()]
                  or colors.surface0
            end,
            bold = function(tab)
               return tab.is_active
            end,
         },
      },
   }

   local buf_lpad = {
      text = function(buffer)
         local remaining_space = get_remaining_space(buffer, parts.buf)
         return string.rep(' ', remaining_space / 2 + remaining_space % 2)
      end,
   }

   local buf_rpad = {
      text = function(buffer)
         local remaining_space = get_remaining_space(buffer, parts.buf)
         return string.rep(' ', remaining_space / 2)
      end,
   }

   ---------------------------------
   -- Setup bufferline
   ---------------------------------
   require('cokeline').setup {
      show_if_buffers_are_at_least = 1,
      buffers = {
         focus_on_delete = 'next',
         new_buffers_position = 'next',
      },
      rendering = {
         max_buffer_width = 25,
      },
      default_hl = {
         bg = function(buf)
            return buf.is_focused and mode_colors[vim.fn.mode()]
               or colors.surface0
         end,
         fg = function(buf)
            return buf.is_focused and hlgroups.get_hl_attr('ColorColumn', 'bg')
               or hlgroups.get_hl_attr('Normal', 'fg')
         end,
         style = function(buf)
            return buf.is_focused and 'bold' or nil
         end,
      },
      sidebar = {
         filetype = 'NvimTree',
         components = {
            {
               text = '  File Browser',
               fg = colors.yellow,
               bg = colors.mantle,
               style = 'bold',
            },
         },
      },
      components = {
         buf_lpad,
         parts.buf.icon,
         parts.buf.space,
         parts.buf.prefix,
         parts.buf.name,
         parts.buf.space,
         buf_rpad,
         parts.buf.modifier,
         parts.buf.space,
      },
      tabs = {
         placement = 'right',
         components = {
            parts.tab.space,
            parts.tab.index,
            parts.tab.space,
         },
      },
   }

   local augroup = vim.api.nvim_create_augroup('CustomCokeline', {})
   vim.api.nvim_clear_autocmds {
      group = augroup,
   }

   vim.api.nvim_create_autocmd('ModeChanged', {
      pattern = '*:*',
      callback = vim.schedule_wrap(function()
         vim.cmd 'redrawtabline'
      end),
   })
end

return spec
