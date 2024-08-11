local Mode = require("consts").modes

vim.g.barbar_auto_setup = false

require("barbar").setup({
  animation = true,
  auto_hide = true,
  closable = true,
  clickable = true,
  exclude_ft = {},
  exclude_name = {},
  icons = {
    filetype = { enabled = true },
    button = '',
    visible = default,
    alternate = default,
    --current = default,
    diagnostics = {
        enabled = true,
        { enabled = true, icon = ' ' }, -- Error.
        { enabled = true, icon = ' ' }, -- Warning.
        { enabled = false }, -- Info.
        { enabled = false }, -- Hint.
    },
    pinned = {
        button = ''
    },
    separator = {
        left = '▎',
        right = ''
    },
    inactive = {
        separator = {
            left = '▎',
            right = ''
        }
    },
    gitsigns = {
        --enabled = true,
        -- Disabled becasue Tokyonight doesnt support all the hightlight
        -- groups
        enabled = false, 
        added = {enabled = true, icon = '+'},
        changed = {enabled = true, icon = '~'},
        deleted = {enabled = true, icon = '-'},
    },
    modified = { button = '●' },
  },
  insert_at_end = false,
  insert_at_start = false,
  letters = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP',
  maximum_padding = 1,
  maximum_length = 30,
  no_name_title = nil,
  semantic_letters = true,
})

vim.keymap.set(Mode.normal, "gt", ":BufferNext<CR>", { noremap = true })
vim.keymap.set(Mode.normal, "gT", ":BufferPrevious<CR>", { noremap = true })
vim.keymap.set(Mode.normal, "gq", ":BufferClose<CR>", { noremap = true })
vim.keymap.set(Mode.normal, "<C-s>", ":BufferMoveNext<CR>", { noremap = true })
vim.keymap.set(Mode.normal, "<C-a>", ":BufferMovePrevious<CR>", { noremap = true })
