-- Central colorscheme configuration
-- Change the colorscheme by updating the ACTIVE_COLORSCHEME variable below

local ACTIVE_COLORSCHEME = "gruvbox"

-- Available colorschemes with their variants
local colorschemes = {
  gruvbox = "gruvbox",
  catppuccin = "catppuccin",
  github_dark = "github_dark",
  github_light = "github_light",
  nightfox = "nightfox",
  dayfox = "dayfox",
  dawnfox = "dawnfox",
  duskfox = "duskfox",
  nordfox = "nordfox",
  terafox = "terafox",
  carbonfox = "carbonfox",
}

return {
  -- Import all theme configurations
  { import = "plugins.themes" },

  -- Configure LazyVim to use the selected colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = colorschemes[ACTIVE_COLORSCHEME] or ACTIVE_COLORSCHEME,
    },
  },
}
