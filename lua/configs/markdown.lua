-- Pretty Markdown Folding

-- Custom fold text for better appearance
local function markdown_fold_text()
  local line = vim.fn.getline(vim.v.foldstart)
  local line_count = vim.v.foldend - vim.v.foldstart + 1
  local fill_count = vim.wo.fillchars:match('fold:(.)')
  local fill_char = fill_count or '─'
  
  -- Extract the header text and level
  local header_text = line:gsub("^#+%s*", "")
  local header_level = #line:match("^#+") or 0
  
  -- Create indent based on header level
  local indent = string.rep("  ", header_level - 1)
  
  -- Create a nice fold text with count
  local fold_text = string.format("%s▸ %s ", indent, header_text)
  local count_text = string.format(" [%d lines] ", line_count)
  
  -- Calculate padding
  local win_width = vim.api.nvim_win_get_width(0)
  local text_width = vim.fn.strdisplaywidth(fold_text .. count_text)
  local padding = win_width - text_width - 1
  
  if padding > 0 then
    return fold_text .. string.rep(fill_char, padding) .. count_text
  else
    return fold_text .. count_text
  end
end

-- Set up fold expression for markdown headers
vim.cmd([[
function! MarkdownFoldExpr()
  let line = getline(v:lnum)
  let next_line = getline(v:lnum + 1)
  
  " Fold on # headers
  if line =~ '^#\+ '
    return '>' . len(matchstr(line, '^#\+'))
  endif
  
  " Fold on === and --- headers
  if next_line =~ '^=\+$' && line =~ '^\S'
    return '>1'
  endif
  
  if next_line =~ '^-\+$' && line =~ '^\S'
    return '>2'
  endif
  
  return '='
endfunction
]])

-- Markdown-specific settings
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    -- Folding settings
    vim.opt_local.foldmethod = "expr"
    vim.opt_local.foldexpr = "MarkdownFoldExpr()"
    vim.opt_local.foldenable = true
    vim.opt_local.foldlevel = 99  -- Start with all folds open
    vim.opt_local.foldlevelstart = 99
    vim.opt_local.fillchars = { fold = '─' }
    vim.opt_local.foldnestmax = 6
    
    -- Use our custom fold text
    vim.opt_local.foldtext = 'v:lua.require("configs.markdown").fold_text()'
    
    -- Better concealing for markdown
    vim.opt_local.conceallevel = 2
    vim.opt_local.concealcursor = "nc"
  end,
})

-- Key mappings for fold operations
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown", 
  callback = function()
    local opts = { buffer = true, silent = true, desc = "Toggle fold" }
    
    -- Main toggle key
    vim.keymap.set("n", "<TAB>", function()
      local line = vim.fn.line('.')
      local foldlevel = vim.fn.foldlevel(line)
      if foldlevel == 0 then
        vim.notify("No fold under cursor", vim.log.levels.INFO)
      else
        vim.cmd("normal! za")
      end
    end, opts)
    
    -- Alternative mappings
    vim.keymap.set("n", "<S-TAB>", "zA", { buffer = true, silent = true, desc = "Toggle all folds" })
    vim.keymap.set("n", "zR", "zR", { buffer = true, silent = true, desc = "Open all folds" })
    vim.keymap.set("n", "zM", "zM", { buffer = true, silent = true, desc = "Close all folds" })
    vim.keymap.set("n", "zo", "zo", { buffer = true, silent = true, desc = "Open fold" })
    vim.keymap.set("n", "zc", "zc", { buffer = true, silent = true, desc = "Close fold" })
    vim.keymap.set("n", "za", "za", { buffer = true, silent = true, desc = "Toggle fold" })
    
    -- Quick fold navigation
    vim.keymap.set("n", "zj", "zj", { buffer = true, silent = true, desc = "Next fold" })
    vim.keymap.set("n", "zk", "zk", { buffer = true, silent = true, desc = "Previous fold" })
  end,
})

-- Export the fold_text function for use in foldtext option
return {
  fold_text = markdown_fold_text
}