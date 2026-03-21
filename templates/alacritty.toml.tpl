# ${name} — тема для Alacritty
# Автор: ${author}
# Сгенерировано из palette.toml

[colors.primary]
background = "#${background}"
foreground = "#${foreground}"

[colors.cursor]
cursor = "#${cursor}"
text   = "#${background}"

[colors.vi_mode_cursor]
cursor = "#${cursor}"
text   = "#${background}"

[colors.selection]
background = "#${selection_bg}"
text       = "#${selection_fg}"

[colors.search.matches]
background = "#${c_bg3}"
foreground = "#${foreground_bright}"

[colors.search.focused_match]
background = "#${info}"
foreground = "#${background}"

# Normal colors
[colors.normal]
black   = "#${background}"
red     = "#${error}"
green   = "#${c_green}"
yellow  = "#${warning}"
blue    = "#${c_blue}"
magenta = "#${constant}"
cyan    = "#${c_cyan}"
white   = "#${foreground}"

# Bright colors
[colors.bright]
black   = "#${c_gray0}"
red     = "#${error}"
green   = "#${c_green_light}"
yellow  = "#${warning}"
blue    = "#${c_blue}"
magenta = "#${c_purple}"
cyan    = "#${c_cyan}"
white   = "#${foreground_bright}"

# Dim colors
[colors.dim]
black   = "#${background}"
red     = "#${c_brown_dark}"
green   = "#${c_green_moss}"
yellow  = "#${c_brown}"
blue    = "#${c_blue_dark}"
magenta = "#${c_dark_purple}"
cyan    = "#${hint}"
white   = "#${foreground_dim}"
