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
"tag" = "#${keyword}"
"attribute" = "#${metadata}"
"punctuation" = "#${green}"
"punctuation.delimiter" = "#${orange}"
"operator" = "#${green}"
"label" = "#${variable}"

# Markup
"markup.heading" = { fg = "#${teal_info}", modifiers = ["bold"] }
"markup.heading.1" = { fg = "#${teal_info}", modifiers = ["bold"] }
"markup.heading.2" = { fg = "#${cyan}", modifiers = ["bold"] }
"markup.heading.3" = { fg = "#${blue}", modifiers = ["bold"] }
"markup.heading.4" = { fg = "#${purple}" }
"markup.heading.5" = { fg = "#${metadata}" }
"markup.heading.6" = { fg = "#${gray1}" }
"markup.bold" = { modifiers = ["bold"] }
"markup.italic" = { modifiers = ["italic"] }
"markup.strikethrough" = { modifiers = ["crossed_out"] }
"markup.link.url" = { fg = "#${yellow}", underline = { style = "line" } }
"markup.link.text" = "#${selection_fg}"
"markup.raw" = "#${green_sage}"
"markup.raw.block" = "#${green_sage}"
"markup.raw.inline" = "#${orange}"
"markup.list" = "#${orange}"
"markup.quote" = { fg = "#${comment_doc_tag}", modifiers = ["italic"] }

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
"ui.cursorline" = { bg = "#${bg_caret_row}" }
"ui.cursorline.secondary" = { bg = "#${bg_indent}" }
"ui.cursorcolumn.primary" = { bg = "#${bg_caret_row}" }
"ui.cursorcolumn.secondary" = { bg = "#${bg_indent}" }
"ui.statusline" = { fg = "#${teal_info}", bg = "#${bg_lookup}" }
"ui.statusline.normal" = { fg = "#${teal_hint}", bg = "#${bg_lookup}", modifiers = ["reversed", "bold"] }
"ui.statusline.insert" = { fg = "#${green_light}", bg = "#${bg_lookup}", modifiers = ["reversed", "bold"] }
"ui.statusline.select" = { fg = "#${ultramarine}", bg = "#${bg_lookup}", modifiers = ["reversed", "bold"] }
"ui.statusline.inactive" = { fg = "#${gray0}", bg = "#${bg_lookup}" }
"ui.popup" = { bg = "#${bg_lookup}" }
"ui.window" = { fg = "#${bg_lookup}", bg = "#${black}" }
"ui.help" = { bg = "#${bg_lookup}", fg = "#${fg0}" }
"ui.selection" = { bg = "#${selection_bg}" }
"ui.selection.primary" = { bg = "#${selection_bg}" }
"ui.cursor.primary" = { modifiers = ["reversed"] }
"ui.cursor.match" = { fg = "#${bg_lookup}", bg = "#${ultramarine}" }
"ui.menu" = { fg = "#${fg0}", bg = "#${bg_lookup}" }
"ui.menu.selected" = { fg = "#${selection_fg}", bg = "#${bg_hint_border}", modifiers = ["bold"] }
"ui.virtual.wrap" = "#${bg_hint_border}"
"ui.virtual.whitespace" = "#${fg1}"
"ui.virtual.indent-guide" = "#${bg_indent}"
"ui.virtual.ruler" = { bg = "#${bg_caret_row}" }
"ui.virtual.inlay-hint" = "#${gray1}"
"ui.virtual.inlay-hint.parameter" = { fg = "#${gray1}", modifiers = ["dim"] }
"ui.virtual.inlay-hint.type" = { fg = "#${gray1}", modifiers = ["dim"] }
"ui.debug.breakpoint" = "#${red}"
"ui.debug.active" = "#${yellow}"

[palette]
