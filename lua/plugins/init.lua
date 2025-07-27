return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "tpope/vim-fugitive",
    lazy = false,
  },

  {
    "NikitaIvanovV/vim-markdown-outline",
    ft = "markdown", 
    config = function()
      -- デフォルトマッピングを有効化
      vim.g.markdown_outline_no_mappings = 0
    end,
  },

  {
    "kdheepak/lazygit.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    config = function()
      vim.g.lazygit_floating_window_use_plenary = 0
      vim.g.lazygit_use_neovim_remote = 1
    end,
  },

  {
    "sindrets/diffview.nvim",
    lazy = false,
    config = function()
      require("diffview").setup({
        diff_binaries = false,
        enhanced_diff_hl = true,
        use_icons = true,
        icons = {
          folder_closed = "",
          folder_open = "",
        },
        signs = {
          fold_closed = "",
          fold_open = "",
          done = "✓",
        },
        view = {
          default = {
            layout = "diff2_horizontal",
            winbar_info = false,
          },
          merge_tool = {
            layout = "diff3_horizontal",
            disable_diagnostics = true,
            winbar_info = true,
          },
          file_history = {
            layout = "diff2_horizontal",
            winbar_info = false,
          },
        },
        file_panel = {
          listing_style = "tree",
          tree_options = {
            flatten_dirs = true,
            folder_statuses = "only_folded",
          },
          win_config = {
            position = "bottom",
            height = 10,
          },
        },
        file_history_panel = {
          log_options = {
            git = {
              single_file = {
                diff_merges = "combined",
              },
              multi_file = {
                diff_merges = "first-parent",
              },
            },
          },
          win_config = {
            position = "bottom",
            height = 10,
          },
        },
        commit_log_panel = {
          win_config = {
            height = 10,
          },
        },
      })
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
    lazy = false,
    config = function()
      require("gitsigns").setup({
        signs = {
          add          = { text = '┃' },
          change       = { text = '┃' },
          delete       = { text = '_' },
          topdelete    = { text = '‾' },
          changedelete = { text = '~' },
          untracked    = { text = '┆' },
        },
        signcolumn = true,
        numhl      = false,
        linehl     = false,
        word_diff  = false,
        watch_gitdir = {
          follow_files = true
        },
        auto_attach = true,
        attach_to_untracked = false,
        current_line_blame = false,
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = 'eol',
          delay = 1000,
          ignore_whitespace = false,
          virt_text_priority = 100,
        },
        current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil,
        max_file_length = 40000,
        preview_config = {
          border = 'single',
          style = 'minimal',
          relative = 'cursor',
          row = 0,
          col = 1
        },
      })
    end,
  },

  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
    config = function()
      -- ブラウザを自動的に開く
      vim.g.mkdp_auto_start = 0
      -- プレビューを自動的に閉じる
      vim.g.mkdp_auto_close = 1
      -- ブラウザを指定（デフォルトブラウザを使用）
      vim.g.mkdp_browser = ''
      -- プレビューオプション
      vim.g.mkdp_preview_options = {
        mkit = {},
        katex = {},
        uml = {},
        maid = {},
        disable_sync_scroll = 0,
        sync_scroll_type = 'middle',
        hide_yaml_meta = 1,
        sequence_diagrams = {},
        flowchart_diagrams = {},
        content_editable = false,
        disable_filename = 0
      }
    end,
  },

  {
    "coder/claudecode.nvim",
    lazy = false,
    config = function()
      require("claudecode").setup({
        -- サイドバーの位置を設定 ('left' または 'right')
        sidebar_position = "left",
        -- サイドバーの幅を設定
        sidebar_width = 40,
        -- その他の設定オプション
        -- auto_focus = false,  -- 自動フォーカスを無効化
        -- keymaps = {          -- キーマップのカスタマイズ
        --   toggle = "<leader>cc",
        --   submit = "<C-Enter>",
        -- }
      })
    end,
  },

  {
    "nvim-orgmode/orgmode",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    event = 'VeryLazy',
    ft = { 'org' },
    config = function()
      require "configs.orgmode"
    end,
  },


  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  {
  	"nvim-treesitter/nvim-treesitter",
  	opts = {
  		ensure_installed = {
  			"vim", "lua", "vimdoc",
       "html", "css", "markdown", "markdown_inline"
  		},
  	},
  },
}
