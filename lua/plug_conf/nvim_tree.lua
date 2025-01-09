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

  wk.add({
    mode = "n",
    buffer=bufnr,
    {"c",         api.fs.create,                    desc="Create node (nvim-tree)" },
    {"d",         api.fs.remove,                    desc="Remove node (nvim-tree)"},
    {"m",         api.fs.rename_sub,                desc="Move node (nvim-tree)"},
    {"y",         api.fs.copy.relative_path,        desc="Copy relative path of node (nvim-tree)"},
    {"Y",         api.fs.copy.absolute_path,        desc="Copy absolute path of node (nvim-tree)"},
    {"r",         api.tree.reload,                  desc="Reload tree (nvim-tree)"},
    {"C",         api.tree.change_root_to_node,     desc="Change root node (nvim-tree)"},
    {"f",         api.tree.toggle_enable_filters,   desc="Toggle filters (nvim-tree)"},
    {"h",         api.tree.toggle_hidden_filters,   desc="Toggle hidden filters (nvim-tree)"},
    {"g",         api.tree.toggle_gitignore_filter, desc="Toggle gitignore filters (nvim-tree)"},
    {"<leader>v", api.node.open.vertical,           desc="Open node in vertical pane (nvim-tree)"},
    {"<leader>h", api.node.open.horizontal,         desc="Open node in horizontal pane (nvim-tree)"},
    {"i",         api.node.show_info_popup,         desc="Display node information (nvim-tree)"},
    {"<CR>",      api.node.open.edit,               desc="Open node in new buffer (nvim-tree)"},
    {">",         inc_width,                        desc="Increase tree pane width (nvim-tree)"},
    {"<",         dec_width,                        desc="Decrease tree pane width (nvim-tree)"},
  })
  
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
