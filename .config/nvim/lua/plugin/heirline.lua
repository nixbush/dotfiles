---------------------------------
-- Set global options
---------------------------------
local colors = require('catppuccin.palettes').get_palette 'macchiato'
local conditions = require 'heirline.conditions'
local utils = require 'heirline.utils'

---------------------------------
-- Components
---------------------------------
local align = { provider = '%=' }
local space = { provider = ' ' }

local stl_vi_mode = {
   init = function(self)
      self.mode = vim.fn.mode(1)
   end,
   static = {
      mode_names = {
         -- change the strings if you like it vvvvverbose!
         n = 'NORMAL',
         no = 'OPERATOR',
         nov = 'OPERATOR',
         noV = 'OPERATOR',
         ['no\22'] = 'OPERATOR',
         niI = 'NORMAL',
         niR = 'NORMAL',
         niV = 'NORMAL',
         nt = 'NORMAL',
         v = 'VISUAL',
         vs = 'VISUAL',
         V = 'VISUAL',
         Vs = 'VISUAL',
         ['\22'] = 'VISUAL',
         ['\22s'] = 'VISUAL',
         s = 'SELECT',
         S = 'SELECT',
         ['\19'] = 'SELECT',
         i = 'INSERT',
         ic = 'INSERT',
         ix = 'INSERT',
         R = 'REPLACE',
         Rc = 'REPLACE',
         Rx = 'REPLACE',
         Rv = 'REPLACE',
         Rvc = 'REPLACE',
         Rvx = 'REPLACE',
         c = 'COMMAND',
         cv = 'VimEx',
         r = 'PROMPT',
         rm = 'PROMPT',
         ['r?'] = 'PROMPT',
         ['!'] = 'SHELL',
         t = 'TERMINAL',
      },
   },
   provider = function(self)
      return ' %2(' .. self.mode_names[self.mode] .. ' %)'
   end,
   hl = function(self)
      return { bg = self:mode_color(), fg = 'base', bold = true }
   end,
   update = {
      'ModeChanged',
      pattern = '*:*',
      callback = vim.schedule_wrap(function()
         vim.cmd 'redrawstatus'
      end),
   },
}

local stl_file_block = {
   init = function(self)
      self.fname = vim.api.nvim_buf_get_name(0)
   end,
}

local stl_file_icon = {
   init = function(self)
      local fname = self.fname
      local extension = vim.fn.fnamemodify(fname, ':e')
      self.icon, self.icon_color = require('nvim-web-devicons').get_icon_color(
         fname,
         extension,
         { default = true }
      )
   end,
   provider = function(self)
      return self.icon and (self.icon .. ' ')
   end,
   hl = function(self)
      return { fg = self.icon_color }
   end,
}

local stl_file_name = {
   provider = function(self)
      local fname = vim.fn.fnamemodify(self.fname, ':.')
      if fname == '' then
         return '[No Name]'
      end
      if not conditions.width_percent_below(#fname, 0.25) then
         fname = vim.fn.pathshorten(fname)
      end
      return fname
   end,
   hl = { fg = 'teal' },
}

local stl_file_flags = {
   {
      condition = function()
         return vim.bo.modified
      end,
      provider = '',
      hl = { fg = 'peach' },
   },
   {
      condition = function()
         return not vim.bo.modifiable or vim.bo.readonly
      end,
      provider = '',
      hl = { fg = 'red' },
   },
}

local stl_file_modifier = {
   hl = function()
      if vim.bo.modified then
         return { fg = 'peach', bold = true, force = true }
      end
      if not vim.bo.modifiable or vim.bo.readonly then
         return { fg = 'red', bold = true, force = true }
      end
      return {}
   end,
}

stl_file_block = utils.insert(
   stl_file_block,
   space,
   stl_file_icon,
   space,
   utils.insert(stl_file_modifier, stl_file_name),
   space,
   stl_file_flags,
   { provider = '%<' },
   space
)

local stl_diagnostics = {
   condition = conditions.has_diagnostics,
   static = {
      error_icon = vim.fn.sign_getdefined('DiagnosticSignError')[1].text,
      warn_icon = vim.fn.sign_getdefined('DiagnosticSignWarn')[1].text,
      info_icon = vim.fn.sign_getdefined('DiagnosticSignInfo')[1].text,
      hint_icon = vim.fn.sign_getdefined('DiagnosticSignHint')[1].text,
   },
   init = function(self)
      self.errors =
         #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
      self.warnings =
         #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
      self.hints =
         #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
      self.info =
         #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
   end,

   update = { 'DiagnosticChanged', 'BufEnter' },

   space,
   space,
   {
      provider = function(self)
         return self.errors > 0 and (self.error_icon .. self.errors .. ' ')
      end,
      hl = { fg = 'red' },
   },
   {
      provider = function(self)
         return self.warnings > 0 and (self.warn_icon .. self.warnings .. ' ')
      end,
      hl = { fg = 'yellow' },
   },
   {
      provider = function(self)
         return self.info > 0 and (self.info_icon .. self.info .. ' ')
      end,
      hl = { fg = 'sky' },
   },
   {
      provider = function(self)
         return self.hints > 0 and (self.hint_icon .. self.hints)
      end,
      hl = { fg = 'teal' },
   },
}

local stl_git = {
   condition = conditions.is_git_repo,

   init = function(self)
      self.status_dict = vim.b.gitsigns_status_dict
      self.has_changes = self.status_dict.added ~= 0
         or self.status_dict.removed ~= 0
         or self.status_dict.changed ~= 0
   end,

   hl = { fg = 'mauve' },
   {
      -- git branch name
      provider = function(self)
         return ' ' .. self.status_dict.head
      end,
      hl = { bold = true },
   },
   -- You could handle delimiters, icons and counts similar to Diagnostics
   {
      condition = function(self)
         return self.has_changes
      end,
      provider = '(',
   },
   {
      provider = function(self)
         local count = self.status_dict.added or 0
         return count > 0 and ('+' .. count)
      end,
      hl = { fg = 'green' },
   },
   {
      provider = function(self)
         local count = self.status_dict.removed or 0
         return count > 0 and ('-' .. count)
      end,
      hl = { fg = 'red' },
   },
   {
      provider = function(self)
         local count = self.status_dict.changed or 0
         return count > 0 and ('~' .. count)
      end,
      hl = { fg = 'peach' },
   },
   {
      condition = function(self)
         return self.has_changes
      end,
      provider = ')',
   },
   space,
   space,
}

local stl_file_type = {
   init = function(self)
      self.fname = vim.api.nvim_buf_get_name(0)
      local extension = vim.fn.fnamemodify(self.fname, ':e')
      self.icon = require('nvim-web-devicons').get_icon(
         self.fname,
         extension,
         { default = true }
      )
   end,
   provider = function(self)
      local ftype = (vim.bo.filetype == '') and 'none' or vim.bo.filetype
      return self.icon .. ' ' .. ftype .. ' '
   end,
   hl = { fg = utils.get_highlight('Type').fg, bold = true },
}

local stl_ruler = {
   init = function(self)
      self.mode = vim.fn.mode(1)
   end,
   provider = '%5l:%-5c',
   hl = function(self)
      return { bg = self:mode_color(), fg = 'base', bold = true }
   end,
}

---------------------------------
-- Statuslines
---------------------------------
local stl_default = {
   hl = { bg = 'mantle' },
   stl_vi_mode,
   stl_file_block,
   stl_diagnostics,
   align,
   align,
   stl_git,
   stl_file_type,
   stl_ruler,
}

local stl_inactive = {
   condition = conditions.is_not_active,
   hl = { bg = 'mantle', fg = utils.get_highlight('Comment').fg, force = true },
   {
      provider = ' INACTIVE ',
      hl = { bold = true },
   },
   stl_file_block,
   align,
   stl_file_type,
   stl_ruler,
}

local stl = {
   fallthrough = false,
   static = {
      mode_colors_map = {
         n = 'blue',
         i = 'green',
         v = 'yellow',
         V = 'yellow',
         ['\22'] = 'yellow',
         c = 'mauve',
         s = 'peach',
         S = 'peach',
         ['\19'] = 'peach',
         R = 'red',
         r = 'lavender',
         ['!'] = 'red',
         t = 'red',
      },
      mode_color = function(self)
         local mode = conditions.is_active() and vim.fn.mode() or 'n'
         return self.mode_colors_map[mode]
      end,
   },
   stl_inactive,
   stl_default,
}

---------------------------------
-- Setup Hyprland
---------------------------------
require('heirline').setup {
   statusline = stl,
   opts = {
      colors = colors,
   },
}
