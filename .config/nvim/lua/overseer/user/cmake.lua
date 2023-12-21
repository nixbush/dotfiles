return {
   condition = function ()
      return vim.fn.filereadable('CMakeLists.txt') == 1
   end
}
