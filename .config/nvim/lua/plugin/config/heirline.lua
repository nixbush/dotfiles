local M = {}

M.config = function()
   local conditions = require 'heirline.conditions'
   local colors = require('dracula').colors()
   local utils = require 'heirline.utils'

   local align = { provider = '%=' }
   local space = { provider = ' ' }

   local vi_mode = {
      init = function(self)
         self.mode = vim.fn.mode()
         if not self.once then
            vim.api.nvim_create_autocmd('ModeChanged', {
               pattern = '*:*o',
               command = 'redrawstatus',
            })
            self.once = true
         end
      end,
      static = {
         mode_names = {
            n = 'NORMAL',
            no = 'NORMAL',
            nov = 'NORMAL',
            noV = 'NORMAL',
            ['no\22'] = 'NORMAL',
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
         mode_colors = {
            n = colors.purple,
            i = colors.green,
            v = colors.yellow,
            V = colors.yellow,
            ['\22'] = colors.yellow,
            c = colors.cyan,
            s = colors.orange,
            S = colors.orange,
            ['\19'] = colors.orange,
            R = colors.red,
            r = colors.red,
            ['!'] = colors.red,
            t = colors.red,
         },
      },
      provider = function(self)
         return ' ' .. self.mode_names[self.mode] .. ' '
      end,
      hl = function(self)
         local mode = self.mode:sub(1, 1) -- Get the first character
         return { fg = self.mode_colors[mode], bold = true }
      end,
      update = { 'ModeChanged' },
   }

   local file_name_block = {
      init = function(self)
         self.filename = vim.api.nvim_buf_get_name(0)
      end,
   }

   local file_icon = {
      init = function(self)
         local filename = self.filename
         local extension = vim.fn.fnamemodify(filename, ':e')

         local devicons = require 'nvim-web-devicons'
         self.icon, self.icon_color =
            devicons.get_icon_color(filename, extension, { default = true })
      end,
      provider = function(self)
         return ' ' .. self.icon .. ' '
      end,
      hl = function(self)
         return { fg = self.icon_color }
      end,
   }

   local file_type = {
      init = function(self)
         local filename = self.filename
         local extension = vim.fn.fnamemodify(filename, ':e')

         local devicons = require 'nvim-web-devicons'
         self.icon, self.icon_color =
            devicons.get_icon_color(filename, extension, { default = true })
      end,
      provider = function()
         return vim.bo.filetype .. ' '
      end,
      hl = function(self)
         return { fg = self.icon_color }
      end,
   }

   local file_name = {
      provider = function(self)
         local filename = vim.fn.fnamemodify(self.filename, ':.')
         if filename == '' then
            return '[No Name]'
         end
         if not conditions.width_percent_below(#filename, 0.25) then
            filename = vim.fn.pathshorten(filename)
         end
         return ' ' .. filename .. ' '
      end,
      hl = { fg = utils.get_highlight('Directory').fg },
   }

   local file_flags = {
      {
         condition = function()
            return vim.bo.modified
         end,
         provider = '',
         hl = { fg = colors.green },
      },
      {
         condition = function()
            return not vim.bo.modifiable or vim.bo.readonly
         end,
         provider = '',
         hl = { fg = colors.orange },
      },
   }

   local file_name_modifier = {
      hl = function()
         if vim.bo.modified then
            return { fg = colors.orange, bold = true, force = true }
         end
      end,
   }

   file_name_block = utils.insert(
      file_name_block,
      file_icon,
      file_type,
      utils.insert(file_name_modifier, file_name),
      file_flags,
      { provider = '%<' }
   )

   local ruler = {
      provider = ' %7(%3l : %-3c%) ',
   }

   local view_percent = {
      provider = '%3p%% ',
      hl = { fg = colors.bright_white, bold = true },
   }

   local file_size = {
      provider = function()
         -- stackoverflow, compute human readable file size
         local suffix = { 'b', 'k', 'M', 'G', 'T', 'P', 'E' }
         local fsize = vim.fn.getfsize(vim.api.nvim_buf_get_name(0))
         fsize = (fsize < 0 and 0) or fsize
         if fsize < 1024 then
            return fsize .. suffix[1]
         end
         local i = math.floor((math.log(fsize) / math.log(1024)))
         return string.format(
            ' %.2g%s ',
            fsize / math.pow(1024, i),
            suffix[i + 1]
         )
      end,
   }

   local diagnostics = {
      condition = conditions.has_diagnostics,
      static = {
         error_icon = ' ',
         warn_icon = ' ',
         info_icon = ' ',
         hint_icon = ' ',
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

      {
         provider = function(self)
            return self.errors > 0 and (self.error_icon .. self.errors .. ' ')
         end,
         hl = { fg = utils.get_highlight('DiagnosticError').fg },
      },
      {
         provider = function(self)
            return self.warnings > 0
               and (self.warn_icon .. self.warnings .. ' ')
         end,
         hl = { fg = utils.get_highlight('DiagnosticWarn').fg },
      },
      {
         provider = function(self)
            return self.info > 0 and (self.info_icon .. self.info .. ' ')
         end,
         hl = { fg = utils.get_highlight('DiagnosticInfo').fg },
      },
      {
         provider = function(self)
            return self.hints > 0 and (self.hint_icon .. self.hints)
         end,
         hl = { fg = utils.get_highlight('DiagnosticHint').fg },
      },
   }

   local lsp_active = {
      condition = conditions.lsp_attached,
      update = { 'LspAttach', 'LspDetach' },

      provider = function()
         local names = {}
         for _, server in pairs(vim.lsp.get_active_clients { bufnr = 0 }) do
            table.insert(names, server.name)
         end
         return '  ' .. table.concat(names, ' ')
      end,
      hl = { fg = colors.comment },
   }

   local term_name = {
      provider = function()
         local tname, _ = vim.api.nvim_buf_get_name(0):gsub('.*:', '')
         return '  ' .. tname
      end,
      hl = { fg = 'blue', bold = true },
   }

   local active_statusline = {
      vi_mode,
      file_name_block,
      align,
      lsp_active,
      align,
      diagnostics,
      file_size,
      ruler,
      view_percent,
   }

   local inactive_statusline = {
      condition = conditions.is_not_active,
      hl = { fg = colors.comment, bg = colors.black, force = true },
      vi_mode,
      file_name_block,
      align,
      file_size,
      ruler,
      view_percent,
   }

   local terminal_statusline = {
      condition = function()
         return conditions.buffer_matches { buftype = { 'terminal' } }
      end,
      vi_mode,
      space,
      file_type,
      space,
      term_name,
      align,
   }

   require('heirline').setup {
      statusline = {
         hl = function()
            if conditions.is_active() then
               return 'StatusLine'
            else
               return 'StatusLineNC'
            end
         end,
         fallthrough = false,
         terminal_statusline,
         inactive_statusline,
         active_statusline,
      },
   }

   vim.o.showtabline = 2
   vim.cmd [[au FileType * if index(['wipe', 'delete'], &bufhidden) >= 0 | set nobuflisted | endif]]
end

return M
