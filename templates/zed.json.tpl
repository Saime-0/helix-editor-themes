{
  "$$schema": "https://zed.dev/schema/themes/v0.2.0.json",
  "name": "${name}",
  "version": "${version}",
  "author": "${author}",
  "themes": [
    {
      "name": "${name}",
      "appearance": "dark",
      "style": {
        "background": "#${black}",
        "editor.background": "#${black}",
        "editor.gutter.background": "#${black}",
        "editor.line_number": "#${gray0}",
        "editor.active_line_number": "#${gray1}",
        "editor.active_line.background": "#${bg_caret_row}",
        "editor.foreground": "#${text_fg}",
        "editor.subheader.background": "#${bg_lookup}",

        "cursor": "#${fg0}",
        "selection": "#${selection_bg}",

        "border": "#${bg_hint_border}",
        "border.variant": "#${bg_indent}",
        "border.focused": "#${variable}",
        "border.selected": "#${variable}",
        "border.transparent": "#00000000",
        "border.disabled": "#${bg_hint_border}",

        "elevated_surface.background": "#${bg_lookup}",
        "surface.background": "#${bg_lookup}",
        "element.background": "#${bg_lookup}",
        "element.hover": "#${bg_hint_border}",
        "element.selected": "#${bg_hint_border}",

        "ghost_element.hover": "#${bg_hint_border}",
        "ghost_element.selected": "#${bg_indent}",

        "text": "#${text_fg}",
        "text.muted": "#${not_used_fg}",
        "text.accent": "#${selection_fg}",

        "icon": "#${text_fg}",
        "icon.muted": "#${not_used_fg}",

        "status_bar.background": "#${bg_lookup}",
        "title_bar.background": "#${bg_lookup}",
        "toolbar.background": "#${black}",
        "tab_bar.background": "#${bg_lookup}",
        "tab.active_background": "#${black}",
        "tab.inactive_background": "#${bg_lookup}",
        "panel.background": "#${bg_lookup}",

        "scrollbar.track.border": "#${bg_hint_border}",
        "scrollbar.thumb.background": "#${bg_indent}",
        "scrollbar.thumb.border": "#${bg_indent}",

        "terminal.background": "#${black}",
        "terminal.foreground": "#${fg1}",
        "terminal.ansi.black": "#${black}",
        "terminal.ansi.red": "#${red}",
        "terminal.ansi.green": "#${green}",
        "terminal.ansi.yellow": "#${yellow}",
        "terminal.ansi.blue": "#${blue}",
        "terminal.ansi.magenta": "#${purple}",
        "terminal.ansi.cyan": "#${cyan}",
        "terminal.ansi.white": "#${fg1}",
        "terminal.ansi.bright_black": "#${gray0}",
        "terminal.ansi.bright_red": "#${fs_deleted}",
        "terminal.ansi.bright_green": "#${green_light}",
        "terminal.ansi.bright_yellow": "#${fs_hijacked}",
        "terminal.ansi.bright_blue": "#${blue}",
        "terminal.ansi.bright_magenta": "#${fs_merged}",
        "terminal.ansi.bright_cyan": "#${teal_info}",
        "terminal.ansi.bright_white": "#${fg0}",

        "error": "#${red}",
        "error.background": "#${red}19",
        "error.border": "#${red}",
        "warning": "#${yellow}",
        "warning.background": "#${yellow}19",
        "warning.border": "#${yellow}",
        "info": "#${teal_info}",
        "info.background": "#${teal_info}19",
        "info.border": "#${teal_info}",
        "hint": "#${teal_hint}",
        "hint.background": "#${teal_hint}19",
        "hint.border": "#${teal_hint}",

        "conflict": "#${fs_merged_conflict}",
        "created": "#${fs_added}",
        "deleted": "#${fs_deleted}",
        "modified": "#${fs_modified}",
        "renamed": "#${teal_info}",

        "players": [
          { "cursor": "#${fg0}", "selection": "#${selection_bg}", "background": "#${fg0}" }
        ],

        "syntax": {
          "keyword": { "color": "#${keyword}" },
          "function": { "color": "#${function}" },
          "function.builtin": { "color": "#${orange}" },
          "function.method": { "color": "#${function}" },
          "function.special": { "color": "#${function_static}", "font_style": "italic" },
          "type": { "color": "#${cyan}" },
          "type.builtin": { "color": "#${orange}" },
          "variable": { "color": "#${variable}" },
          "variable.special": { "color": "#${orange}" },
          "constant": { "color": "#${purple}" },
          "constant.builtin": { "color": "#${orange}" },
          "number": { "color": "#${blue}" },
          "string": { "color": "#${string}" },
          "string.special": { "color": "#${orange}" },
          "comment": { "color": "#${comment_line}" },
          "comment.doc": { "color": "#${comment_doc}", "font_style": "italic" },
          "operator": { "color": "#${green}" },
          "punctuation": { "color": "#${green}" },
          "punctuation.delimiter": { "color": "#${orange}" },
          "label": { "color": "#${variable}" },
          "attribute": { "color": "#${metadata}" },
          "tag": { "color": "#${keyword}" },
          "property": { "color": "#${variable}" },
          "namespace": { "color": "#${green_sage}" },
          "boolean": { "color": "#${orange}" },
          "embedded": { "color": "#${template_fg}" },
          "link_uri": { "color": "#${yellow}" },
          "link_text": { "color": "#${selection_fg}" },
          "title": { "color": "#${teal_info}", "font_weight": 700 }
        }
      }
    }
  ]
}
