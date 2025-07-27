-- Git関連のキーマップ設定
local map = vim.keymap.set

-- Diffview
map("n", "<leader>gd", ":DiffviewOpen<CR>", { desc = "Git diff view" })
map("n", "<leader>gh", ":DiffviewFileHistory %<CR>", { desc = "Git file history" })
map("n", "<leader>gc", ":DiffviewClose<CR>", { desc = "Close diffview" })

-- Gitsigns
map("n", "]c", function()
  if vim.wo.diff then
    vim.cmd.normal({']c', bang = true})
  else
    require('gitsigns').nav_hunk('next')
  end
end, { desc = "Next hunk" })

map("n", "[c", function()
  if vim.wo.diff then
    vim.cmd.normal({'[c', bang = true})
  else
    require('gitsigns').nav_hunk('prev')
  end
end, { desc = "Prev hunk" })

map("n", "<leader>hs", ":Gitsigns stage_hunk<CR>", { desc = "Stage hunk" })
map("n", "<leader>hr", ":Gitsigns reset_hunk<CR>", { desc = "Reset hunk" })
map("n", "<leader>hS", ":Gitsigns stage_buffer<CR>", { desc = "Stage buffer" })
map("n", "<leader>hu", ":Gitsigns undo_stage_hunk<CR>", { desc = "Undo stage hunk" })
map("n", "<leader>hR", ":Gitsigns reset_buffer<CR>", { desc = "Reset buffer" })
map("n", "<leader>hp", ":Gitsigns preview_hunk<CR>", { desc = "Preview hunk" })
map("n", "<leader>hb", ":Gitsigns blame_line<CR>", { desc = "Blame line" })
map("n", "<leader>tb", ":Gitsigns toggle_current_line_blame<CR>", { desc = "Toggle line blame" })
map("n", "<leader>hd", ":Gitsigns diffthis<CR>", { desc = "Diff this" })
map("n", "<leader>hD", function() require('gitsigns').diffthis('~') end, { desc = "Diff this ~" })

-- LazyGit
map("n", "<leader>lg", ":LazyGit<CR>", { desc = "LazyGit" })

-- Formatting
map("n", "<leader>fm", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format file" })