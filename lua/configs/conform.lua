local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettier" },
    html = { "prettier" },
    javascript = { "prettier", "eslint" },
    javascriptreact = { "prettier", "eslint" },
    typescript = { "prettier", "eslint" },
    typescriptreact = { "prettier", "eslint" },
    json = { "prettier" },
    markdown = { "prettier" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
