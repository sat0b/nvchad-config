local orgmode = require('orgmode')

orgmode.setup({
  org_agenda_files = {'~/Documents/org/*', '~/my-orgs/**/*'},
  org_default_notes_file = '~/Documents/org/refile.org',
  org_hide_leading_stars = true,
  org_hide_emphasis_markers = true,
  org_indent_mode = 'indent',
  org_todo_keywords = {'TODO', 'PROGRESS', '|', 'DONE', 'CANCELED'},
  org_todo_keyword_faces = {
    TODO = ':foreground red :weight bold',
    PROGRESS = ':foreground yellow :weight bold',
    DONE = ':foreground green :weight bold',
    CANCELED = ':foreground gray :slant italic',
  },
  org_deadline_warning_days = 14,
  org_agenda_span = 'week',
  org_capture_templates = {
    t = {
      description = 'Task',
      template = '* TODO %?\n  %u',
      target = '~/Documents/org/todo.org'
    },
    j = {
      description = 'Journal',
      template = '* %<%Y-%m-%d %H:%M>\n%?',
      target = '~/Documents/org/journal.org'
    },
    n = {
      description = 'Note',
      template = '* %?\n  %u',
      target = '~/Documents/org/notes.org'
    }
  },
  mappings = {
    global = {
      org_agenda = '<leader>oa',
      org_capture = '<leader>oc',
    },
    org = {
      org_toggle_checkbox = '<C-Space>',
      org_cycle = '<TAB>',
      org_global_cycle = '<S-TAB>',
      org_open_at_point = '<CR>',
      org_todo = '<leader>ot',
      org_todo_prev = '<S-Left>',
      org_todo_next = '<S-Right>',
      org_insert_heading_respect_content = '<leader>oih',
      org_insert_todo_heading = '<leader>oit',
      org_insert_todo_heading_respect_content = '<leader>oiT',
      org_move_subtree_up = '<leader>ok',
      org_move_subtree_down = '<leader>oj',
      org_export = '<leader>oe',
      org_next_visible_heading = ']]',
      org_previous_visible_heading = '[[',
      org_forward_heading_same_level = ']}',
      org_backward_heading_same_level = '[{',
    }
  }
})