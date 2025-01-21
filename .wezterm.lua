-- why wezterm over alacritty : multiplexer feature

-- Pull in the wezterm API
local wezterm = require("wezterm")

-- Create a configuration table
local config = {}

--  minimized window borders
config.window_decorations = "RESIZE"

-- Font settings
config.font = wezterm.font_with_fallback({
	"0xProto Nerd Font Mono",
})
config.font_size = 14.0

-- Colors
config.colors = {
	foreground = "#dcd7ba", -- Kanagawa foreground
	background = "#1f1f28", -- Kanagawa background
	cursor_bg = "#c8c093", -- Cursor background
	cursor_fg = "#1f1f28", -- Cursor foreground
	ansi = {
		"#1f1f28", -- black
		"#c34043", -- red
		"#76946a", -- green
		"#c0a36e", -- yellow
		"#7e9cd8", -- blue
		"#957fb8", -- magenta
		"#6a9589", -- cyan
		"#dcd7ba", -- white
	},
	brights = {
		"#727169", -- bright black
		"#e82424", -- bright red
		"#98bb6c", -- bright green
		"#e6c384", -- bright yellow
		"#7fb4ca", -- bright blue
		"#938aa9", -- bright magenta
		"#7aa89f", -- bright cyan
		"#dcd7ba", -- bright white
	},
}

-- Window opacity and blur
config.window_background_opacity = 0.9
config.macos_window_background_blur = 20 -- Changed to integer to avoid error

-- Disable padding for a clean look when using applications like nvim
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

-- Tab bar appearance
config.use_fancy_tab_bar = true
--config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true

-- Scrollback settings
config.scrollback_lines = 5000

-- Enable Wayland support if using Wayland
if wezterm.target_triple == "x86_64-unknown-linux-gnu" then
	config.enable_wayland = true
end

-- multiplexer config
-- ctl + space to trigger
--  awsome , now i can be happy with helix
config.leader = { key = "Space", mods = "CTRL", timeout_milliseconds = 2000 }
config.keys = {

	--NOTE: spliting
	{ -- vertical split
		mods = "LEADER",
		key = "=",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{ -- horizontal split
		mods = "LEADER",
		key = "-",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	--NOTE: Zoom in/out
	{
		mods = "LEADER",
		key = "m",
		action = wezterm.action.TogglePaneZoomState,
	},

	--NOTE: close
	{
		mods = "LEADER",
		key = "x",
		action = wezterm.action.CloseCurrentPane({ confirm = true }),
	},

	--NOTE: choose pane
	{
		mods = "LEADER",
		key = "h",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	{
		mods = "LEADER",
		key = "j",
		action = wezterm.action.ActivatePaneDirection("Down"),
	},
	{
		mods = "LEADER",
		key = "k",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},
	{
		mods = "LEADER",
		key = "l",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},
	--NOTE: rotate panes
	{
		mods = "LEADER",
		key = "Space",
		action = wezterm.action.RotatePanes("Clockwise"),
	},
	--NOTE: pane selection, swap wtih active pane
	{
		mods = "LEADER",
		key = "o",
		action = wezterm.action.PaneSelect({ mode = "SwapWithActive" }),
	},
}

-- Return the completed configuration table
return config

-- some short cuts
-- ctrl shift  f : search
