# ${name} — тема для Helix
# Автор: ${author}
# Сгенерировано из palette.toml

# Синтаксис (из IDEA)
"keyword" = "#${keyword}"
"type" = "#${cyan}"
"type.builtin" = "#${orange}"
"constant" = "#${purple}"
"constant.numeric" = "#${blue}"
"constant.builtin" = "#${orange}"
"function" = "#${function}"
"function.builtin" = "#${orange}"
"function.method" = "#${function}"
"function.special" = { fg = "#${function_static}", modifiers = ["italic"] }
"variable" = "#${variable}"
"variable.builtin" = "#${orange}"
"namespace" = "#${green_sage}"
"string" = "#${string}"
"string.special" = "#${orange}"
"comment" = "#${comment_line}"
"comment.block" = "#${comment_block}"
"comment.block.documentation" = { fg = "#${comment_doc}", modifiers = ["italic"] }
"attribute" = "#${metadata}"
"punctuation" = "#${green}"
"punctuation.delimiter" = "#${orange}"
"operator" = "#${green}"
"label" = "#${variable}"

"diff.plus" = "#${green_light}"
"diff.delta" = "#${yellow}"
"diff.minus" = "#${red}"

"warning" = "#${yellow}"
"error" = "#${red}"
"info" = "#${teal_info}"
"hint" = "#${teal_hint}"

"diagnostic.error" = { underline = { style = "curl", color = "#${red}" } }
"diagnostic.warning" = { underline = { style = "curl", color = "#${yellow}" } }
"diagnostic.info" = { underline = { style = "curl", color = "#${teal_info}" } }
"diagnostic.hint" = { underline = { style = "curl", color = "#${teal_hint}" } }

# UI
"ui.background" = { bg = "#${black}" }
"ui.text" = { fg = "#${fg1}" }
"ui.text.focus" = { fg = "#${selection_fg}" }
"ui.linenr" = { fg = "#${gray0}" }
"ui.linenr.selected" = { fg = "#${gray1}", modifiers = ["bold"] }
"ui.cursorline" = { bg = "#${hx_bg1}" }
"ui.cursorline.secondary" = { bg = "#${hx_bg2}" }
"ui.cursorcolumn.primary" = { bg = "#${hx_bg1}" }
"ui.cursorcolumn.secondary" = { bg = "#${hx_bg2}" }
"ui.statusline" = { fg = "#${teal_info}", bg = "#${hx_bg1}" }
"ui.statusline.normal" = { fg = "#${teal_hint}", bg = "#${hx_bg1}", modifiers = ["reversed", "bold"] }
"ui.statusline.insert" = { fg = "#${green_light}", bg = "#${hx_bg1}", modifiers = ["reversed", "bold"] }
"ui.statusline.select" = { fg = "#${ultramarine}", bg = "#${hx_bg1}", modifiers = ["reversed", "bold"] }
"ui.statusline.inactive" = { fg = "#${gray0}", bg = "#${hx_bg1}" }
"ui.popup" = { bg = "#${hx_bg1}" }
"ui.window" = { fg = "#${hx_bg1}", bg = "#${black}" }
"ui.help" = { bg = "#${hx_bg1}", fg = "#${fg0}" }
"ui.selection" = { bg = "#${hx_selection_bg}" }
"ui.selection.primary" = { bg = "#${hx_selection_bg}" }
"ui.cursor.primary" = { modifiers = ["reversed"] }
"ui.cursor.match" = { fg = "#${hx_bg1}", bg = "#${ultramarine}" }
"ui.menu" = { fg = "#${fg0}", bg = "#${hx_bg1}" }
"ui.menu.selected" = { fg = "#${selection_fg}", bg = "#${hx_bg2}", modifiers = ["bold"] }
"ui.virtual.wrap" = "#${hx_bg2}"
"ui.virtual.whitespace" = "#${fg1}"
"ui.virtual.indent-guide" = "#${hx_bg2}"
"ui.virtual.ruler" = { bg = "#${hx_bg1}" }
"ui.virtual.inlay-hint" = "#${gray1}"
"ui.virtual.inlay-hint.parameter" = { fg = "#${gray1}", modifiers = ["dim"] }
"ui.virtual.inlay-hint.type" = { fg = "#${gray1}", modifiers = ["dim"] }
"ui.debug.breakpoint" = "#${red}"
"ui.debug.active" = "#${yellow}"

[palette]
