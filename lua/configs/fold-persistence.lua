-- Fold persistence configuration
-- This module handles saving and restoring fold states across sessions

local M = {}

-- Create autocmds for fold persistence
function M.setup()
  -- Create augroup for fold persistence
  local augroup = vim.api.nvim_create_augroup("fold_persistence", { clear = true })
  
  -- Save folds when leaving a window or writing a file
  vim.api.nvim_create_autocmd({ "BufWinLeave", "BufWritePost" }, {
    group = augroup,
    pattern = "*",
    callback = function(event)
      -- Skip special buffers
      local buftype = vim.bo[event.buf].buftype
      if buftype ~= '' and buftype ~= 'acwrite' then
        return
      end
      
      -- Skip if file doesn't exist
      local file = vim.fn.expand("<afile>:p")
      if file == '' or not vim.fn.filereadable(file) then
        return
      end
      
      -- Save view
      vim.cmd("silent! mkview 1")
    end,
  })
  
  -- Load folds when entering a window
  vim.api.nvim_create_autocmd("BufWinEnter", {
    group = augroup,
    pattern = "*",
    callback = function(event)
      -- Skip special buffers
      local buftype = vim.bo[event.buf].buftype
      if buftype ~= '' and buftype ~= 'acwrite' then
        return
      end
      
      -- Skip if file doesn't exist
      local file = vim.fn.expand("<afile>:p")
      if file == '' or not vim.fn.filereadable(file) then
        return
      end
      
      -- Load view
      vim.cmd("silent! loadview 1")
      
      -- Ensure folds are enabled after loading
      vim.opt_local.foldenable = true
    end,
  })
end

-- Initialize on module load
M.setup()

return M