#!/bin/bash
# Bash syntax demo for theme preview.

set -euo pipefail

# Constants
readonly MAX_RETRY=3
readonly HEX_FLAG=0xFF
readonly GREETING="hello, world"
readonly CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"

# Arrays
declare -a TASKS=("build" "test" "deploy")
declare -A STATUS=(
    [build]="pending"
    [test]="pending"
    [deploy]="pending"
)

# Functions
log() {
    local level="$1"
    shift
    printf '[%s] %s: %s\n' "$(date +%T)" "$level" "$*" >&2
}

execute_task() {
    local name="$1"
    local retry="${2:-0}"

    if [[ -z "$name" ]]; then
        log "ERROR" "task name cannot be empty"
        return 1
    fi

    STATUS[$name]="running"
    log "INFO" "executing: $name (attempt $((retry + 1)))"

    # Command substitution, arithmetic
    local start_time
    start_time=$(date +%s)

    if command -v "$name" &>/dev/null; then
        "$name" || return $?
    fi

    local elapsed=$(( $(date +%s) - start_time ))
    log "INFO" "$name completed in ${elapsed}s"

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
            log "WARN" "retry $((retry + 1)) for $task"
        done

        if [[ "$success" != true ]]; then
            log "ERROR" "failed: $task"
            return 1
        fi
    done

    # Join results
    local IFS=', '
    echo "completed: ${results[*]}"
}

# Conditions, glob, regex
check_config() {
    local file="$1"

    if [[ ! -f "$file" ]]; then
        log "ERROR" "file not found: $file"
        return 1
    fi

    # Regex match
    if [[ "$file" =~ ^.*\.(toml|json|ya?ml)$ ]]; then
        log "INFO" "configuration: ${BASH_REMATCH[1]}"
    fi

    # Case
    case "${file##*.}" in
        toml) cat "$file" ;;
        json) python3 -m json.tool "$file" ;;
        yaml|yml) cat "$file" ;;
        *) log "WARN" "unknown format" ;;
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

# Heredoc without interpolation
show_help() {
    cat <<'EOF'
Usage:
    ./preview.sh [command]

Commands:
    run      run all tasks
    check    check configuration
    help     show this help
EOF
}

# Pipe, subshell, process substitution
count_done() {
    local count
    count=$(printf '%s\n' "${STATUS[@]}" | grep -c "done" || true)
    echo "completed: $count of ${#STATUS[@]}"
}

# Trap
cleanup() {
    log "INFO" "cleaning up..."
    rm -f /tmp/preview_*.tmp
}
trap cleanup EXIT

# Entry point
main() {
    local cmd="${1:-run}"

    case "$cmd" in
        run)   process_all ;;
        check) check_config "${2:-palette.toml}" ;;
        help)  show_help ;;
        *)     log "ERROR" "unknown command: $cmd"; exit 1 ;;
    esac
}

main "$@"
