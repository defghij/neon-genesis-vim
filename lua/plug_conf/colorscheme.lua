require("tokyonight").setup {
  style = "night",
  light_style = "day",
  transparent = true,
  terminal_colors = true,
  styles = {
    --sidebars = "dark",
    --floats = "dark",
    sidebars = "transparent",
    floats = "transparent",
  },
  day_brightness = 0.3,
  dim_inactive = false,
  lualine_bold = false,

  on_colors = function(colors) end,
  plugins = {
    all = package.loaded.lazy == nil,
    auto = true,
  },
}

require('lualine').setup {
  options = {
    theme = 'tokyonight'
  }
}
vim.cmd("colorscheme tokyonight")
