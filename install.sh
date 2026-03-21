#!/bin/bash
# Генерирует темы и копирует в нужные места.
# Использование:
#   ./install.sh              # всё
#   ./install.sh helix zed    # только указанные

set -euo pipefail

DIR="$(cd "$(dirname "$0")" && pwd)"
TARGETS=("${@:-helix idea zed alacritty vscode}")

python3 "$DIR/generate.py" "${TARGETS[@]}"

for target in "${TARGETS[@]}"; do
    case "$target" in
        helix)
            dest="$HOME/.config/helix/themes"
            mkdir -p "$dest"
            cp "$DIR/output/helix.toml" "$dest/black-warm.toml"
            echo "  helix: $dest/black-warm.toml"
            ;;
        idea)
            for ide_dir in "$HOME"/.config/JetBrains/*/; do
                [ -d "$ide_dir" ] || continue
                dest="${ide_dir}colors"
                mkdir -p "$dest"
                cp "$DIR/output/idea.icls" "$dest/black-warm.icls"
                echo "  idea: $dest/black-warm.icls"
            done
            ;;
        zed)
            dest="$HOME/.config/zed/themes"
            mkdir -p "$dest"
            cp "$DIR/output/zed.json" "$dest/black-warm.json"
            echo "  zed: $dest/black-warm.json"
            ;;
        alacritty)
            dest="$HOME/.config/alacritty/themes"
            mkdir -p "$dest"
            cp "$DIR/output/alacritty.toml" "$dest/black-warm.toml"
            echo "  alacritty: $dest/black-warm.toml"
            ;;
        vscode)
            dest="$HOME/.vscode/extensions/black-warm-theme/themes"
            mkdir -p "$dest"
            cp "$DIR/output/vscode.json" "$dest/black-warm-color-theme.json"
            # package.json for the extension
            cat > "$(dirname "$dest")/package.json" <<'PKGJSON'
{
  "name": "black-warm-theme",
  "displayName": "Black Warm",
  "version": "0.1.0",
  "engines": { "vscode": "^1.60.0" },
  "categories": ["Themes"],
  "contributes": {
    "themes": [{
      "label": "Black Warm",
      "uiTheme": "vs-dark",
      "path": "./themes/black-warm-color-theme.json"
    }]
  }
}
PKGJSON
            echo "  vscode: $dest/black-warm-color-theme.json"
            ;;
        *)
            echo "  неизвестная цель: $target" >&2
            ;;
    esac
done
