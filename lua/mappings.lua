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

-- Neorg mappings
map("n", "<leader>nn", "<cmd>Neorg workspace notes<cr>", { desc = "Neorg notes workspace" })
map("n", "<leader>nw", "<cmd>Neorg workspace work<cr>", { desc = "Neorg work workspace" })
map("n", "<leader>np", "<cmd>Neorg workspace personal<cr>", { desc = "Neorg personal workspace" })
map("n", "<leader>nj", "<cmd>Neorg journal today<cr>", { desc = "Neorg journal today" })
map("n", "<leader>ni", "<cmd>Neorg index<cr>", { desc = "Neorg index" })
map("n", "<leader>nr", "<cmd>Neorg return<cr>", { desc = "Neorg return" })
