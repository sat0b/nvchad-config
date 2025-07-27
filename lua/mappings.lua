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
