# ${name} — тема для Helix
# Автор: ${author}
# Сгенерировано из palette.toml

"keyword" = "#${keyword}"
"type" = "#${type}"
"type.builtin" = "#${type_builtin}"
"constant" = "#${constant}"
"constant.numeric" = "#${constant_numeric}"
"constant.builtin" = "#${constant_builtin}"
"function" = "#${function}"
"function.builtin" = "#${function_builtin}"
"variable" = "#${variable}"
"variable.builtin" = "#${variable_builtin}"
"namespace" = "#${namespace}"
"string" = "#${string}"
"string.special" = "#${string_special}"
"comment" = "#${comment}"
"punctuation" = "#${punctuation}"
"punctuation.delimiter" = "#${punctuation_delimiter}"
"operator" = "#${operator}"
"label" = "#${label}"

"diff.plus" = "#${diff_added}"
"diff.delta" = "#${diff_modified}"
"diff.minus" = "#${diff_removed}"

"warning" = "#${warning}"
"error" = "#${error}"
"info" = "#${info}"
"hint" = "#${hint}"

"diagnostic.error" = { underline = { style = "curl", color = "#${error}" } }
"diagnostic.warning" = { underline = { style = "curl", color = "#${warning}" } }
"diagnostic.info" = { underline = { style = "curl", color = "#${info}" } }
"diagnostic.hint" = { underline = { style = "curl", color = "#${hint}" } }

"ui.background" = { bg = "#${background}" }
"ui.text" = { fg = "#${foreground}" }
"ui.text.focus" = { fg = "#${selection_fg}" }
"ui.linenr" = { fg = "#${line_number}" }
"ui.linenr.selected" = { fg = "#${line_number_active}", modifiers = ["bold"] }
"ui.cursorline" = { bg = "#${background1}" }
"ui.cursorline.secondary" = { bg = "#${background2}" }
"ui.cursorcolumn.primary" = { bg = "#${background1}" }
"ui.cursorcolumn.secondary" = { bg = "#${background2}" }
"ui.statusline" = { fg = "#${info}", bg = "#${background1}" }
"ui.statusline.normal" = { fg = "#${hint}", bg = "#${background1}", modifiers = ["reversed", "bold"] }
"ui.statusline.insert" = { fg = "#${diff_added}", bg = "#${background1}", modifiers = ["reversed", "bold"] }
"ui.statusline.select" = { fg = "#${constant}", bg = "#${background1}", modifiers = ["reversed", "bold"] }
"ui.statusline.inactive" = { fg = "#${line_number}", bg = "#${background1}" }
"ui.popup" = { bg = "#${background1}" }
"ui.window" = { fg = "#${background1}", bg = "#${background}" }
"ui.help" = { bg = "#${background1}", fg = "#${foreground_bright}" }
"ui.selection" = { bg = "#${selection_bg}" }
"ui.selection.primary" = { bg = "#${selection_bg}" }
"ui.cursor.primary" = { modifiers = ["reversed"] }
"ui.cursor.match" = { fg = "#${background1}", bg = "#${constant}" }
"ui.menu" = { fg = "#${foreground_bright}", bg = "#${background1}" }
"ui.menu.selected" = { fg = "#${selection_fg}", bg = "#${background2}", modifiers = ["bold"] }
"ui.virtual.wrap" = "#${background2}"
"ui.virtual.whitespace" = "#${foreground}"
"ui.virtual.indent-guide" = "#${background2}"
"ui.virtual.ruler" = { bg = "#${background1}" }
"ui.virtual.inlay-hint" = "#${line_number_active}"
"ui.virtual.inlay-hint.parameter" = { fg = "#${line_number_active}", modifiers = ["dim"] }
"ui.virtual.inlay-hint.type" = { fg = "#${line_number_active}", modifiers = ["dim"] }
"ui.debug.breakpoint" = "#${error}"
"ui.debug.active" = "#${warning}"

[palette]
