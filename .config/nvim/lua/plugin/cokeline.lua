---------------------------------
-- Set mappings
---------------------------------
local map = vim.keymap.set
map('n', 'H', '<Plug>(cokeline-focus-prev)')
map('n', 'L', '<Plug>(cokeline-focus-next)')
map('n', '<C-u>', '<Plug>(cokeline-switch-prev)')
map('n', '<C-i>', '<Plug>(cokeline-switch-next)')

---------------------------------
-- Set global options
---------------------------------
local colors = require('catppuccin.palettes').get_palette 'macchiato'
local utils = require 'cokeline/utils'
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
local component = {
   space = {
      text = ' ',
      truncation = { priority = 1 },
   },

   file_icon = {
      text = function(buf)
         return buf.devicon.icon .. ' '
      end,
      truncation = { priority = 1 },
   },

   file_prefix = {
      text = function(buf)
         return buf.unique_prefix
      end,
      style = 'italic',
      truncation = { priority = 3, direction = 'left' },
   },

   file_name = {
      text = function(buf)
         return buf.filename
      end,
      truncation = { priority = 2, direction = 'left' },
   },

   file_modifier = {
      text = function(buf)
         return buf.is_modified and '' or '󰅖'
      end,
      delete_buffer_on_left_click = true,
      truncation = { priority = 1 },
   },
}

local get_remaining_space = function(buffer)
   local used_space = 0
   for _, c in pairs(component) do
      used_space = used_space
         + vim.fn.strwidth(
            (type(c.text) == 'string' and c.text)
               or (type(c.text) == 'function' and c.text(buffer))
         )
   end
   return math.max(0, min_buf_width - used_space)
end

local left_padding = {
   text = function(buffer)
      local remaining_space = get_remaining_space(buffer)
      return string.rep(' ', remaining_space / 2 + remaining_space % 2)
   end,
}

local right_padding = {
   text = function(buffer)
      local remaining_space = get_remaining_space(buffer)
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
         return buf.is_focused and mode_colors[vim.fn.mode()] or colors.surface0
      end,
      fg = function(buf)
         return buf.is_focused and utils.get_hex('ColorColumn', 'bg')
            or utils.get_hex('Normal', 'fg')
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
            bg = 'base',
            style = 'bold',
         },
      },
   },

   components = {
      left_padding,
      component.file_icon,
      component.file_prefix,
      component.file_name,
      component.space,
      right_padding,
      component.file_modifier,
      component.space,
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
