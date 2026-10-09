#!/bin/sh

set -e


fail () {
  msg="${1}"
  echo "${msg}"
  exit 1
}


mongo_hostnames_with_default_port() {
  hostnames="${1}"
  hosts=''
  for host in $(echo "${hostnames}" | tr ',' ' '); do
    case "$host" in
      *:*) ;;
      *) host="${host}:27017" ;;
    esac
    hosts="${hosts:+${hosts},}${host}"
  done
  echo "$hosts"
}


wait_for_host() {
  host="${1%%:*}"
  port="${1##*:}"

  max_attempts=30
  attempt="${max_attempts}"
  timeout=10

  while [ "${attempt}" -gt 0 ]; do
    current_attempt=$((max_attempts - attempt))
    echo "Try to connect '${host}:${port}'[Attempt: ${current_attempt}/${max_attempts}]"
    if nc -z -w "${timeout}" "${host}" "${port}" 2>/dev/null; then
      echo "Connection successfully!"
      return 0
    fi
    attempt=$((attempt - 1))
    sleep "${timeout}"
  done
  fail "Timed out waiting for connect to '${host}:${port}'"
}


wait_for_hosts() {
  hosts_env="${1}"
  mongo_hostnames=$(mongo_hostnames_with_default_port "$hosts_env")
  for host_with_port in $(echo "$mongo_hostnames" | tr ',' ' '); do
    wait_for_host "${host_with_port}"
  done
}


build_mongo_uri() {
  user="${1}"
  password="${2}"
  hosts="${3}"
  replica_sets="${4}"
  mongo_hostnames=$(mongo_hostnames_with_default_port "$hosts")
  uri="mongodb://${user}:${password}@${mongo_hostnames}/admin?replicaSet=${replica_sets}&authSource=admin"
  echo "${uri}"
}


if [ -n "${MONGO_HOSTS}" ]; then
  echo "Waiting for ${MONGO_HOSTS}"
  wait_for_hosts "${MONGO_HOSTS}"
fi

if [ -n "${MONGO_AUDIT_HOSTS}" ]; then
  echo "Waiting for ${MONGO_AUDIT_HOSTS}"
  wait_for_hosts "${MONGO_AUDIT_HOSTS}"
fi

if [ -z "${MONGO_URI}" ]; then
  MONGO_URI=$(build_mongo_uri "${MONGO_USER}" \
    "$(cat /run/secrets/mongo_exporter_password)" \
    "${MONGO_HOSTS}" \
    "${MONGO_REPLICA_SET}")
fi

if [ -z "${MONGO_AUDIT_URI}" ] && [ -n "${MONGO_AUDIT_HOSTS}" ]; then
  MONGO_AUDIT_URI=$(build_mongo_uri "${MONGO_AUDIT_USER}" \
    "$(cat /run/secrets/audit_mongo_exporter_password)" \
    "${MONGO_AUDIT_HOSTS}" \
    "${MONGO_AUDIT_REPLICA_SET}")
fi

_MONGO_URIS="${MONGO_URI}"
if [ -n "${MONGO_AUDIT_URI}" ]; then
  _MONGO_URIS="${_MONGO_URIS},${MONGO_AUDIT_URI}"
fi

exec /opt/mongodb_exporter \
  --collector.diagnosticdata \
  --collector.replicasetstatus \
  --collector.dbstats \
  --collector.topmetrics \
  --collector.currentopmetrics \
  --discovering-mode \
  --split-cluster \
  --mongodb.uri="${_MONGO_URIS}" \
