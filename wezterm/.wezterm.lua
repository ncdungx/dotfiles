local wezterm = require('wezterm')
local config = wezterm.config_builder()

config.window_close_confirmation = 'NeverPrompt'
config.hide_tab_bar_if_only_one_tab = true
config.initial_cols = 90
config.initial_rows = 27
config.font = wezterm.font('Iosevka Term Extended')
config.font_size = 12
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
config.use_resize_increments = true
config.color_scheme = 'Kanagawa (Gogh)'
config.front_end = 'WebGpu'
webgpu_power_preference = 'HighPerformance'

return config
