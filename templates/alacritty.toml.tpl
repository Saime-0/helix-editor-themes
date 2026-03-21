# ${name} v${version} — тема для Alacritty
# Автор: ${author}
# Сгенерировано из palette.toml

[colors.primary]
background = "#${black}"
foreground = "#${fg1}"

[colors.cursor]
cursor = "#${fg0}"
text   = "#${black}"

[colors.vi_mode_cursor]
cursor = "#${fg0}"
text   = "#${black}"

[colors.selection]
background = "#${selection_bg}"
text       = "#${selection_fg}"

[colors.search.matches]
background = "#${search_bg}"
foreground = "#${fg0}"

[colors.search.focused_match]
background = "#${teal_info}"
foreground = "#${black}"

# Normal colors
[colors.normal]
black   = "#${black}"
red     = "#${red}"
green   = "#${green}"
yellow  = "#${yellow}"
blue    = "#${blue}"
magenta = "#${purple}"
cyan    = "#${cyan}"
white   = "#${fg1}"

# Bright colors
[colors.bright]
black   = "#${gray0}"
red     = "#${fs_deleted}"
green   = "#${green_light}"
yellow  = "#${fs_hijacked}"
blue    = "#${blue}"
magenta = "#${fs_merged}"
cyan    = "#${teal_info}"
white   = "#${fg0}"

# Dim colors
[colors.dim]
black   = "#${black}"
red     = "#${function}"
green   = "#${comment_line}"
yellow  = "#${keyword}"
blue    = "#${variable}"
magenta = "#${dark_purple}"
cyan    = "#${teal_hint}"
white   = "#${not_used_fg}"
