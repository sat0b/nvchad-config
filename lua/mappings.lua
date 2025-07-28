require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { desc = "Go to definition" })
map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", { desc = "Show references" })
map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { desc = "Show hover information" })
map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", { desc = "Rename symbol" })

-- UFO folding
map("n", "zR", function() require("ufo").openAllFolds() end, { desc = "Open all folds" })
map("n", "zM", function() require("ufo").closeAllFolds() end, { desc = "Close all folds" })
map("n", "zr", function() require("ufo").openFoldsExceptKinds() end, { desc = "Open folds except kinds" })
map("n", "zm", function() require("ufo").closeFoldsWith() end, { desc = "Close folds with" })


-- Markdown specific folding
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    -- Use Enter to toggle folds on lists and headings
    map("n", "<CR>", function()
      local line = vim.fn.getline('.')
      -- Check if we're on a list item or heading
      if line:match('^%s*[-*+]') or line:match('^%s*%d+%.') or line:match('^#') then
        require('ufo').peekFoldedLinesUnderCursor()
        if vim.fn.foldclosed('.') ~= -1 then
          vim.cmd('normal! zo')
        else
          vim.cmd('normal! zc')
        end
      else
        vim.cmd('normal! za')
      end
    end, { desc = "Toggle fold", buffer = true })
    
    -- Preview folded content
    map("n", "K", function()
      local winid = require('ufo').peekFoldedLinesUnderCursor()
      if not winid then
        vim.lsp.buf.hover()
      end
    end, { desc = "Peek fold or hover", buffer = true })
  end,
})

-- Markdown outline mapping
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    -- カスタムコマンドを定義
    vim.api.nvim_buf_create_user_command(0, "MarkdownOutline", function()
      vim.cmd("normal \\<Plug>MarkdownOutline")
    end, { desc = "Show markdown outline" })
    
    -- 追加のマッピング
    vim.keymap.set("n", "<leader>mo", "<Plug>MarkdownOutline", 
      { desc = "Markdown outline", buffer = true })
  end,
})

map("n", "gO", "<Plug>MarkdownOutline", { desc = "Markdown outline", buffer = true })

-- lazygit mappings
map("n", "<leader>lg", "<cmd>LazyGit<cr>", { desc = "LazyGit" })
map("n", "<leader>lf", "<cmd>LazyGitCurrentFile<cr>", { desc = "LazyGit current file" })
map("n", "<leader>lc", "<cmd>LazyGitConfig<cr>", { desc = "LazyGit config" })

-- fugitive mappings
map("n", "<leader>gs", "<cmd>Git<cr>", { desc = "Git status" })
map("n", "<leader>gd", function()
  local width = vim.o.columns
  if width < 160 then
    vim.cmd("Gdiffsplit --horizontal")
  else
    vim.cmd("Gdiffsplit")
  end
end, { desc = "Git diff (smart split)" })
map("n", "<leader>gD", "<cmd>DiffToggleSplit<cr>", { desc = "Toggle diff split orientation" })
map("n", "<leader>gb", "<cmd>Git blame<cr>", { desc = "Git blame" })

-- Markdown notes mappings
map("n", "<leader>nn", "<cmd>NoteNew<cr>", { desc = "Create new note" })
map("n", "<leader>nq", ":NoteQuick ", { desc = "Quick note (enter title)" })
map("n", "<leader>nt", "<cmd>NoteToday<cr>", { desc = "Today's note" })
map("n", "<leader>nr", "<cmd>NoteRecent<cr>", { desc = "Recent note" })
map("n", "<leader>nl", "<cmd>NoteList<cr>", { desc = "List all notes" })
map("n", "<leader>np", "<cmd>NoteProjects<cr>", { desc = "Browse projects" })
map("n", "<leader>nf", "<cmd>NoteFindFile<cr>", { desc = "Find note files" })
map("n", "<leader>ng", "<cmd>NoteGrep<cr>", { desc = "Search in notes" })
map("n", "<leader>ne", "<cmd>NoteExplorer<cr>", { desc = "Toggle note explorer" })
map("n", "<leader>nR", "<cmd>NoteRename<cr>", { desc = "Rename current note" })
map("n", "<leader>nd", "<cmd>NoteDelete<cr>", { desc = "Delete current note" })
map("n", "<leader>nD", "<cmd>NoteDeleteMulti<cr>", { desc = "Delete multiple notes" })
