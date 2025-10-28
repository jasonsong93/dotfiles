-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.

-- For example, changing the initial geometry for new windows:
config.initial_cols = 120
config.initial_rows = 28

-- or, changing the font size and color scheme.
config.font_size = 20
config.font = wezterm.font('JetbrainsMono Nerd Font')
config.color_scheme = 'OceanicMaterial'
config.use_dead_keys = false
config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = true

-- Finally, return the configuration to wezterm:
return config
