require "nvchad.options"

-- add yours here!

local o = vim.o
o.swapfile = false
-- o.cursorlineopt ='both' -- to enable cursorline!

-- Auto-reload settings
o.autoread = true
o.updatetime = 300

-- UFO folding
o.foldcolumn = '0'  -- Hide fold column (no +/- or numbers)
o.foldlevel = 99
o.foldlevelstart = 99
o.foldenable = true

-- Persist fold states
o.viewoptions = 'cursor,folds,slash,unix'
o.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,terminal'

-- Load fold persistence configuration
require("configs.fold-persistence")
