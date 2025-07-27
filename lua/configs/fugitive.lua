-- Fugitive configuration for adaptive diff split

-- Auto-adjust diff split based on window width
vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = "*",
  callback = function()
    -- Only apply to fugitive diff buffers
    if vim.bo.filetype == "fugitive" or vim.fn.expand("%"):match("^fugitive://") then
      return
    end
    
    -- Check if this is a diff view
    if vim.wo.diff then
      local width = vim.api.nvim_win_get_width(0)
      
      -- If window is narrow (less than 160 chars total), use horizontal split
      if width < 160 then
        vim.cmd("wincmd K")  -- Move window to top (horizontal split)
      end
    end
  end,
})

-- Custom commands for diff with smart splitting
vim.api.nvim_create_user_command("Gdiffsplit", function(opts)
  local width = vim.o.columns
  
  -- Choose split direction based on terminal width
  if width < 160 then
    -- Horizontal split for narrow screens
    vim.cmd("Gdiffsplit " .. (opts.args or "") .. " --horizontal")
  else
    -- Vertical split for wide screens (default)
    vim.cmd("Gdiffsplit " .. (opts.args or ""))
  end
end, { nargs = "*", complete = "customlist,fugitive#CompleteObject" })

-- Override default Gdiffsplit behavior
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    -- Create an abbreviation to use our custom command
    vim.cmd("cabbrev Gdiffsplit <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'Gdiffsplit' : 'Gdiffsplit')<CR>")
  end,
})

-- Function to toggle between vertical and horizontal diff
vim.api.nvim_create_user_command("DiffToggleSplit", function()
  if vim.wo.diff then
    local wins = vim.api.nvim_list_wins()
    local diff_wins = {}
    
    -- Find all diff windows
    for _, win in ipairs(wins) do
      if vim.api.nvim_win_get_option(win, "diff") then
        table.insert(diff_wins, win)
      end
    end
    
    if #diff_wins >= 2 then
      -- Check current layout
      local win1_pos = vim.api.nvim_win_get_position(diff_wins[1])
      local win2_pos = vim.api.nvim_win_get_position(diff_wins[2])
      
      vim.api.nvim_set_current_win(diff_wins[2])
      
      if win1_pos[1] == win2_pos[1] then
        -- Currently vertical, switch to horizontal
        vim.cmd("wincmd K")
      else
        -- Currently horizontal, switch to vertical
        vim.cmd("wincmd L")
      end
    end
  end
end, {})

-- Keymaps for git operations with smart diff
vim.api.nvim_create_autocmd("FileType", {
  pattern = {"fugitive", "git"},
  callback = function()
    local opts = { buffer = true, silent = true }
    
    -- Smart diff split
    vim.keymap.set("n", "gd", function()
      local width = vim.o.columns
      if width < 160 then
        vim.cmd("Gdiffsplit --horizontal")
      else
        vim.cmd("Gdiffsplit")
      end
    end, vim.tbl_extend("force", opts, { desc = "Git diff (smart split)" }))
    
    -- Toggle diff split orientation
    vim.keymap.set("n", "gD", ":DiffToggleSplit<CR>", 
      vim.tbl_extend("force", opts, { desc = "Toggle diff split orientation" }))
  end,
})