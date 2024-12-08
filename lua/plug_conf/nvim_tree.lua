local winsize = require("utils").winsize
local api = require("nvim-tree.api")
local mode = require("consts").modes
local bufferline_api = require("bufferline.api")
local wk = require("which-key")

local DEFAULT_WIDTH = 30

local function inc_width()
  local width, _height = winsize()
  local new_width = width + 10

  vim.cmd(string.format("NvimTreeResize %d", new_width))
end

local function dec_width()
  local width, _height = winsize()

  local new_width = width - 10

  if new_width < DEFAULT_WIDTH then return end

  vim.cmd(string.format("NvimTreeResize %d", new_width))
end

local function on_attach(bufnr)
  local opts = { buffer = bufnr, noremap = true, silent = true, nowait = true }

  vim.keymap.set(mode.normal, "c", api.fs.create, opts)
  vim.keymap.set(mode.normal, "d", api.fs.remove, opts)
  vim.keymap.set(mode.normal, "m", api.fs.rename_sub, opts)
  vim.keymap.set(mode.normal, "y", api.fs.copy.relative_path, opts)
  vim.keymap.set(mode.normal, "Y", api.fs.copy.absolute_path, opts)
  vim.keymap.set(mode.normal, "r", api.tree.reload, opts)
  vim.keymap.set(mode.normal, "C", api.tree.change_root_to_node, opts)
  vim.keymap.set(mode.normal, "h", api.tree.toggle_hidden_filter, opts)
  vim.keymap.set(mode.normal, "f", api.tree.toggle_enable_filters, opts)
  vim.keymap.set(mode.normal, "f", api.tree.toggle_enable_filters, opts)
  vim.keymap.set(mode.normal, "g", api.tree.toggle_gitignore_filter, opts)
  vim.keymap.set(mode.normal, "<leader>v", api.node.open.vertical, opts)
  vim.keymap.set(mode.normal, "<leader>h", api.node.open.horizontal, opts)
  vim.keymap.set(mode.normal, "i", api.node.show_info_popup, opts)
  vim.keymap.set(mode.normal, "o", api.node.open.edit, opts)
  vim.keymap.set(mode.normal, "<CR>", api.node.open.edit, opts)
  vim.keymap.set(mode.normal, ">", inc_width, opts)
  vim.keymap.set(mode.normal, "<", dec_width, opts)
end

require("nvim-tree").setup({
  auto_reload_on_write = true,
  hijack_cursor = true,
  update_focused_file = {
    enable = true
  },
  sort_by = "name",
  filters = {
    custom = {
      ".git*",
      ".bash*",
    }
  },
  renderer = {
    highlight_opened_files = "name",
  },
  on_attach = on_attach,
  view = {
    side = "left",
    adaptive_size = false,
    centralize_selection = true,
    width = DEFAULT_WIDTH,
  },
})

api.events.subscribe(api.events.Event.Resize, function(new_size)
  bufferline_api.set_offset(new_size, "File Tree")
end)

-- TODO Figure out how to condiitionally add the attach_on buffer commands
wk.add({
  { "<leader>e", ":NvimTreeToggle<CR>", mode="n", group = "Files", desc = "Open nvim-tree file manager" },
})
