#! /bin/sh

log() {
  echo "$(date '+%Y-%m-%d %H:%M:%S') [healthcheck ] ${*}"
}

run_check() {
  name="$1"
  shift
  log "Running: ${name}"

  exit_code=0
  output=$("${@}" 2>&1) || exit_code=$?

  printf '%s\n' "$output" | while IFS= read -r line; do
    log " | $line"
  done

  if [ "${exit_code}" -eq 0 ]; then
    log "OK: ${name}"
  else
    log "FAILED: ${name}"
    exit "${exit_code}"
  fi
}

"$@"
