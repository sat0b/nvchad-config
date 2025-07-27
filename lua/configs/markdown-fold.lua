-- Enhanced Pretty Markdown Folding with icons and colors

local M = {}

-- Configuration
local config = {
  icons = {
    fold_closed = "▸",
    fold_open = "▾",
    h1 = "󰉫",  -- or "◉", "●", "▶"
    h2 = "󰉬",  -- or "○", "◐", "▷" 
    h3 = "󰉭",  -- or "▪", "◆", "▸"
    h4 = "󰉮",  -- or "▫", "◇", "▹"
    h5 = "󰉯",  -- or "▪", "◈", "▸"
    h6 = "󰉰",  -- or "▫", "◊", "▹"
    default = "▸"
  },
  fill_char = "─",
  show_line_count = true,
}

-- Get icon for header level
local function get_header_icon(level)
  local icons = config.icons
  if level == 1 then return icons.h1
  elseif level == 2 then return icons.h2
  elseif level == 3 then return icons.h3
  elseif level == 4 then return icons.h4
  elseif level == 5 then return icons.h5
  elseif level == 6 then return icons.h6
  else return icons.default end
end

-- Custom fold text function
function M.fold_text()
  local line = vim.fn.getline(vim.v.foldstart)
  local line_count = vim.v.foldend - vim.v.foldstart + 1
  
  -- Extract header info
  local header_text = line:gsub("^#+%s*", "")
  local header_level = #(line:match("^#+") or "")
  
  -- Get appropriate icon
  local icon = get_header_icon(header_level)
  
  -- No indent for maximum left alignment
  -- local indent = string.rep(" ", math.max(0, header_level - 1))
  
  -- Build fold text (more compact)
  local fold_icon = config.icons.fold_closed
  local fold_text = string.format("%s %s %s", fold_icon, icon, header_text)
  
  -- Add line count if enabled
  local suffix = ""
  if config.show_line_count then
    suffix = string.format(" [%d]", line_count)
  end
  
  -- Calculate padding for fill
  local win_width = vim.api.nvim_win_get_width(0)
  local text_width = vim.fn.strdisplaywidth(fold_text .. suffix)
  local padding = win_width - text_width - 1
  
  -- Return formatted fold text
  if padding > 0 then
    return fold_text .. " " .. string.rep(config.fill_char, padding - 1) .. suffix
  else
    return fold_text .. suffix
  end
end

-- Setup function
function M.setup()
  -- Set up fold expression
  vim.cmd([[
  function! MarkdownFoldExpr()
    let line = getline(v:lnum)
    let next_line = getline(v:lnum + 1)
    
    " Fold on # headers
    if line =~ '^#\+ '
      return '>' . len(matchstr(line, '^#\+'))
    endif
    
    " Fold on === headers (h1)
    if next_line =~ '^=\+$' && line =~ '^\S'
      return '>1'
    endif
    
    " Fold on --- headers (h2)
    if next_line =~ '^-\+$' && line =~ '^\S'
      return '>2'
    endif
    
    return '='
  endfunction
  ]])

  -- Markdown autocmd
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
      -- Folding options
      vim.opt_local.foldmethod = "expr"
      vim.opt_local.foldexpr = "MarkdownFoldExpr()"
      vim.opt_local.foldenable = true
      vim.opt_local.foldlevel = 99
      vim.opt_local.foldlevelstart = 99
      vim.opt_local.fillchars = { fold = config.fill_char }
      vim.opt_local.foldnestmax = 6
      
      -- Custom fold text
      vim.opt_local.foldtext = 'v:lua.require("configs.markdown-fold").fold_text()'
      
      -- Disable concealing to show code fences
      vim.opt_local.conceallevel = 0
      -- vim.opt_local.concealcursor = "nc"
      
      -- Disable fold column for more space
      vim.opt_local.foldcolumn = "0"
    end,
  })

  -- Keymaps
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
      local map = vim.keymap.set
      local opts = { buffer = true, silent = true }
      
      -- Smart toggle with visual feedback
      map("n", "<TAB>", function()
        local line = vim.fn.line('.')
        if vim.fn.foldlevel(line) > 0 then
          vim.cmd("normal! za")
          -- Optional: flash the line
          vim.cmd("redraw")
        else
          vim.notify("No fold here", vim.log.levels.WARN, { title = "Markdown Fold" })
        end
      end, vim.tbl_extend("force", opts, { desc = "Toggle fold" }))
      
      -- Other mappings
      map("n", "<S-TAB>", "zA", vim.tbl_extend("force", opts, { desc = "Toggle all folds recursively" }))
      map("n", "<leader>z0", "zR", vim.tbl_extend("force", opts, { desc = "Open all folds" }))
      map("n", "<leader>zc", "zM", vim.tbl_extend("force", opts, { desc = "Close all folds" }))
      map("n", "<leader>za", "za", vim.tbl_extend("force", opts, { desc = "Toggle fold" }))
      map("n", "<leader>zA", "zA", vim.tbl_extend("force", opts, { desc = "Toggle fold recursively" }))
      
      -- Navigation
      map("n", "zj", "zj", vim.tbl_extend("force", opts, { desc = "Next fold" }))
      map("n", "zk", "zk", vim.tbl_extend("force", opts, { desc = "Previous fold" }))
      
      -- Fold at specific level
      map("n", "<leader>z1", ":set foldlevel=0<CR>", vim.tbl_extend("force", opts, { desc = "Fold level 1" }))
      map("n", "<leader>z2", ":set foldlevel=1<CR>", vim.tbl_extend("force", opts, { desc = "Fold level 2" }))
      map("n", "<leader>z3", ":set foldlevel=2<CR>", vim.tbl_extend("force", opts, { desc = "Fold level 3" }))
    end,
  })

  -- Highlight groups for better visibility
  vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function()
      vim.api.nvim_set_hl(0, 'Folded', { bg = 'NONE', fg = '#7c8f8f' })
      vim.api.nvim_set_hl(0, 'FoldColumn', { bg = 'NONE', fg = '#5c6f7f' })
    end,
  })
end

return M