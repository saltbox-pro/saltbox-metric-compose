#!/bin/sh

set -e

with_ports() {
  hosts=''
  for host in $(echo "$1" | tr ',' ' '); do
    case "$host" in
      *:*) ;;
      *) host="${host}:27017" ;;
    esac
    hosts="${hosts:+${hosts},}${host}"
  done
  echo "$hosts"
}

if [ -z "$MONGO_URI" ]; then
  MONGO_URI="mongodb://$(with_ports "$MONGO_HOSTS")/admin?replicaSet=${MONGO_REPLICA_SET}&authSource=admin"
fi

if [ -z "$MONGO_AUDIT_URI" ]; then
  MONGO_AUDIT_URI="mongodb://$(with_ports "$MONGO_AUDIT_HOSTS")/admin?replicaSet=${MONGO_AUDIT_REPLICA_SET}&authSource=admin"
fi

MONGODB_USER="$MONGO_USER"
MONGODB_PASSWORD=$(cat /run/secrets/mongo_exporter_password)
export MONGODB_USER MONGODB_PASSWORD

exec /opt/mongodb_exporter \
  --collector.diagnosticdata \
  --collector.replicasetstatus \
  --collector.dbstats \
  --collector.topmetrics \
  --collector.currentopmetrics \
  --discovering-mode \
  --split-cluster \
  --mongodb.uri="${MONGO_URI},${MONGO_AUDIT_URI}" \
