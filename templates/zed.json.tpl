{
  "$$schema": "https://zed.dev/schema/themes/v0.2.0.json",
  "name": "${name}",
  "author": "${author}",
  "themes": [
    {
      "name": "${name}",
      "appearance": "dark",
      "style": {
        "background": "#${background}",
        "editor.background": "#${background}",
        "editor.gutter.background": "#${background}",
        "editor.line_number": "#${line_number}",
        "editor.active_line_number": "#${line_number_active}",
        "editor.active_line.background": "#${background1}",
        "editor.foreground": "#${foreground}",
        "editor.subheader.background": "#${background1}",

        "cursor": "#${cursor}",
        "selection": "#${selection_bg}",

        "border": "#${background2}",
        "border.variant": "#${background3}",
        "border.focused": "#${c_blue_dark}",
        "border.selected": "#${c_blue_dark}",
        "border.transparent": "#00000000",
        "border.disabled": "#${background2}",

        "elevated_surface.background": "#${background1}",
        "surface.background": "#${background1}",
        "element.background": "#${background1}",
        "element.hover": "#${background2}",
        "element.selected": "#${background2}",

        "ghost_element.hover": "#${background2}",
        "ghost_element.selected": "#${background3}",

        "text": "#${foreground}",
        "text.muted": "#${foreground_dim}",
        "text.accent": "#${selection_fg}",

        "icon": "#${foreground}",
        "icon.muted": "#${foreground_dim}",

        "status_bar.background": "#${background1}",
        "title_bar.background": "#${background1}",
        "toolbar.background": "#${background}",
        "tab_bar.background": "#${background1}",
        "tab.active_background": "#${background}",
        "tab.inactive_background": "#${background1}",
        "panel.background": "#${background1}",

        "scrollbar.track.border": "#${background2}",
        "scrollbar.thumb.background": "#${background3}",
        "scrollbar.thumb.border": "#${background3}",

        "terminal.background": "#${background}",
        "terminal.foreground": "#${foreground}",
        "terminal.ansi.black": "#${background}",
        "terminal.ansi.red": "#${error}",
        "terminal.ansi.green": "#${c_green}",
        "terminal.ansi.yellow": "#${warning}",
        "terminal.ansi.blue": "#${c_blue}",
        "terminal.ansi.magenta": "#${constant}",
        "terminal.ansi.cyan": "#${c_cyan}",
        "terminal.ansi.white": "#${foreground}",
        "terminal.ansi.bright_black": "#${c_gray0}",
        "terminal.ansi.bright_red": "#${error}",
        "terminal.ansi.bright_green": "#${c_green_light}",
        "terminal.ansi.bright_yellow": "#${warning}",
        "terminal.ansi.bright_blue": "#${c_blue}",
        "terminal.ansi.bright_magenta": "#${c_purple}",
        "terminal.ansi.bright_cyan": "#${c_cyan}",
        "terminal.ansi.bright_white": "#${foreground_bright}",

        "error": "#${error}",
        "error.background": "#${error}19",
        "error.border": "#${error}",
        "warning": "#${warning}",
        "warning.background": "#${warning}19",
        "warning.border": "#${warning}",
        "info": "#${info}",
        "info.background": "#${info}19",
        "info.border": "#${info}",
        "hint": "#${hint}",
        "hint.background": "#${hint}19",
        "hint.border": "#${hint}",

        "conflict": "#${warning}",
        "created": "#${diff_added}",
        "deleted": "#${diff_removed}",
        "modified": "#${diff_modified}",
        "renamed": "#${info}",

        "players": [
          { "cursor": "#${cursor}", "selection": "#${selection_bg}", "background": "#${cursor}" }
        ],

        "syntax": {
          "keyword": { "color": "#${keyword}" },
          "function": { "color": "#${function}" },
          "type": { "color": "#${type}" },
          "variable": { "color": "#${variable}" },
          "variable.special": { "color": "#${variable_builtin}" },
          "constant": { "color": "#${constant}" },
          "number": { "color": "#${constant_numeric}" },
          "string": { "color": "#${string}" },
          "string.special": { "color": "#${string_special}" },
          "comment": { "color": "#${comment}" },
          "operator": { "color": "#${operator}" },
          "punctuation": { "color": "#${punctuation}" },
          "punctuation.delimiter": { "color": "#${punctuation_delimiter}" },
          "label": { "color": "#${label}" },
          "attribute": { "color": "#${constant}" },
          "tag": { "color": "#${keyword}" },
          "property": { "color": "#${variable}" },
          "namespace": { "color": "#${namespace}" },
          "boolean": { "color": "#${constant_builtin}" },
          "embedded": { "color": "#${string_special}" }
        }
      }
    }
  ]
}
