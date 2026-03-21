#!/usr/bin/env python3
"""
Генератор цветовых тем из единой палитры.
Без внешних зависимостей — только stdlib Python 3.11+.

Использование:
    python3 generate.py                # всё
    python3 generate.py helix alacritty # только указанные
"""

import json
import sys
import tomllib
from pathlib import Path
from string import Template

ROOT = Path(__file__).parent
PALETTE_FILE = ROOT / "palette.toml"
TEMPLATES_DIR = ROOT / "templates"
OUTPUT_DIR = ROOT / "output"


def load_palette() -> dict:
    """Загружает palette.toml → плоский dict для подстановки."""
    with open(PALETTE_FILE, "rb") as f:
        data = tomllib.load(f)

    ctx = {}

    # Мета
    ctx.update(data.get("meta", {}))

    # Все цвета напрямую
    colors = data.get("colors", {})
    ctx.update(colors)

    # Варианты с # для удобства: ${keyword_h} → #69472c
    for key, val in list(ctx.items()):
        if isinstance(val, str) and len(val) == 6 and all(
            c in "0123456789abcdefABCDEF" for c in val
        ):
            ctx[f"{key}_h"] = f"#{val}"

    return ctx


def deep_merge(base: dict, override: dict) -> dict:
    """Рекурсивно мержит override в base."""
    for key, val in override.items():
        if key in base and isinstance(base[key], dict) and isinstance(val, dict):
            deep_merge(base[key], val)
        else:
            base[key] = val
    return base


def json_merge(base_text: str, override_text: str, source: str) -> str:
    """Мержит JSON-оверрайд поверх сгенерированного JSON."""
    try:
        base = json.loads(base_text)
        override = json.loads(override_text)
        merged = deep_merge(base, override)
        return json.dumps(merged, indent=2, ensure_ascii=False) + "\n"
    except json.JSONDecodeError as e:
        print(f"  ошибка JSON merge для {source}: {e}", file=sys.stderr)
        return base_text


def generate(targets: list[str] | None = None):
    """Генерирует темы из шаблонов."""
    ctx = load_palette()
    OUTPUT_DIR.mkdir(exist_ok=True)

    templates = sorted(TEMPLATES_DIR.glob("*.tpl"))
    if not templates:
        print("Нет шаблонов в templates/")
        return

    for tpl_path in templates:
        # Имя цели: helix.toml.tpl → helix
        target_name = tpl_path.stem.split(".")[0]
        if targets and target_name not in targets:
            continue

        # Имя выходного файла: helix.toml.tpl → helix.toml
        out_name = tpl_path.name.removesuffix(".tpl")
        out_path = OUTPUT_DIR / out_name

        tpl_text = tpl_path.read_text()
        tpl = Template(tpl_text)

        try:
            result = tpl.substitute(ctx)
        except (KeyError, ValueError) as e:
            print(f"  ошибка в {tpl_path.name}: {e}", file=sys.stderr)
            continue

        # Применяем оверрайд если есть
        override_path = TEMPLATES_DIR / f"{out_name}.override"
        if override_path.exists():
            override_text = override_path.read_text()
            override_text = Template(override_text).safe_substitute(ctx)

            if out_name.endswith(".json"):
                result = json_merge(result, override_text, tpl_path.name)
            else:
                result = result.rstrip("\n") + "\n\n" + override_text

        out_path.write_text(result)
        print(f"  {tpl_path.name} → output/{out_name}")

    print("готово.")


if __name__ == "__main__":
    targets = sys.argv[1:] if len(sys.argv) > 1 else None
    generate(targets)
