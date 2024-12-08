require("mason").setup()
local wk = require("which-key")

local lspconfig = require("lspconfig")

lspconfig["bashls"].setup({})
lspconfig["clangd"].setup({})
--lspconfig["docker_compose_language_service"].setup({})
--lspconfig["dockerls"].setup({})
--lspconfig["eslint"].setup({})
--lspconfig["html"].setup({})
--lspconfig["lua_ls"].setup({})
--lspconfig["marksman"].setup({})
--lspconfig["pyright"].setup({})
--lspconfig["yamlls"].setup({})

lspconfig["rust_analyzer"].setup({
  settings = {
    ["rust-analyzer"] = {
      diagnostics = {
        --disabled = { "inactive-code" },
      }
    },
  },
})

-- lsp_signature UI tweaks
require("lsp_signature").setup({
  bind = true,
  handler_opts = {
    border = "rounded",
  },
})

-- LSP hover window UI tweaks
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover, {
    border = "single"
  }
)

-- LSP diagnostics
vim.diagnostic.config {
    float = { border = "single" },
    underline = true,
    virtual_text = false,
    virtual_lines = false
}

-- Key bindings to be set after LSP attaches to buffer
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    vim.api.nvim_buf_set_option(ev.buf, "omnifunc", "v:lua.vim.lsp.omnifunc")
    vim.api.nvim_buf_set_option(ev.buf, "formatexpr", "v:lua.vim.lsp.formatexpr()")

    local opts = { buffer = ev.buf }
    wk.add({
      {"?", vim.lsp.buf.hover,             desc = "token documentation (hover)"},
      {"gd", vim.lsp.buf.declaration,      desc = "token declaration (buffer)"},
      {"gD", vim.lsp.buf.definition,       desc = "token definition (buffer)"},
      {"gI", vim.lsp.buf.implementation,   desc = "token implementation (buffer)"},
      {"gC", vim.lsp.buf.code_action,      desc = "prompt for code actions (hover)"},
      {"g>", vim.lsp.diagnostic.goto_next, desc = "move to next diagnostic (cursor)"},
      {"g<", vim.lsp.diagnostic.goto_prev, desc = "move to next diagnostic (cursor)"},
      {"gR", vim.lsp.buf.references,       desc = "open reference to token (buffer)"},
    })
  end,
})
