#!/bin/bash
# Демонстрация синтаксиса Bash для проверки темы.

set -euo pipefail

# Константы
readonly MAX_RETRY=3
readonly HEX_FLAG=0xFF
readonly GREETING="привет, мир"
readonly CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"

# Массивы
declare -a TASKS=("build" "test" "deploy")
declare -A STATUS=(
    [build]="pending"
    [test]="pending"
    [deploy]="pending"
)

# Функции
log() {
    local level="$1"
    shift
    printf '[%s] %s: %s\n' "$(date +%T)" "$level" "$*" >&2
}

execute_task() {
    local name="$1"
    local retry="${2:-0}"

    if [[ -z "$name" ]]; then
        log "ERROR" "имя задачи не может быть пустым"
        return 1
    fi

    STATUS[$name]="running"
    log "INFO" "выполняю: $name (попытка $((retry + 1)))"

    # Подстановка команд, арифметика
    local start_time
    start_time=$(date +%s)

    if command -v "$name" &>/dev/null; then
        "$name" || return $?
    fi

    local elapsed=$(( $(date +%s) - start_time ))
    log "INFO" "$name завершено за ${elapsed}с"

    STATUS[$name]="done"
}

process_all() {
    local results=()

    for task in "${TASKS[@]}"; do
        local success=false
        for (( retry=0; retry < MAX_RETRY; retry++ )); do
            if execute_task "$task" "$retry"; then
                success=true
                results+=("$task: ok")
                break
            fi
            log "WARN" "retry $((retry + 1)) для $task"
        done

        if [[ "$success" != true ]]; then
            log "ERROR" "не удалось: $task"
            return 1
        fi
    done

    # Join результатов
    local IFS=', '
    echo "завершено: ${results[*]}"
}

# Условия, glob, regex
check_config() {
    local file="$1"

    if [[ ! -f "$file" ]]; then
        log "ERROR" "файл не найден: $file"
        return 1
    fi

    # Regex match
    if [[ "$file" =~ ^.*\.(toml|json|ya?ml)$ ]]; then
        log "INFO" "конфигурация: ${BASH_REMATCH[1]}"
    fi

    # Case
    case "${file##*.}" in
        toml) cat "$file" ;;
        json) python3 -m json.tool "$file" ;;
        yaml|yml) cat "$file" ;;
        *) log "WARN" "неизвестный формат" ;;
    esac
}

# Here document
generate_config() {
    cat <<EOF
[meta]
name = "$GREETING"
workers = ${WORKERS:-4}
debug = ${DEBUG:-false}
EOF
}

# Heredoc без интерполяции
show_help() {
    cat <<'EOF'
Использование:
    ./preview.sh [команда]

Команды:
    run      запуск всех задач
    check    проверка конфигурации
    help     эта справка
EOF
}

# Pipe, subshell, process substitution
count_done() {
    local count
    count=$(printf '%s\n' "${STATUS[@]}" | grep -c "done" || true)
    echo "завершено: $count из ${#STATUS[@]}"
}

# Trap
cleanup() {
    log "INFO" "очистка..."
    rm -f /tmp/preview_*.tmp
}
trap cleanup EXIT

# Точка входа
main() {
    local cmd="${1:-run}"

    case "$cmd" in
        run)   process_all ;;
        check) check_config "${2:-palette.toml}" ;;
        help)  show_help ;;
        *)     log "ERROR" "неизвестная команда: $cmd"; exit 1 ;;
    esac
}

main "$@"
