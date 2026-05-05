#!/bin/sh

set -e

EXPORTER_PASSWORD_FILE="/run/secrets/mongo_exporter_password"
EXPORTER_PASSWORD=$(cat "${EXPORTER_PASSWORD_FILE}")
MONGO_URI="mongodb://${MONGO_USER}:${EXPORTER_PASSWORD}@${MONGO_HOSTNAME}:27017/admin?replicaSet=${MONGO_REPLICA_SET}&authSource=admin,mongodb://${MONGO_USER}:${EXPORTER_PASSWORD}@${MONGO_AUDIT_HOSTNAME}:27017/admin?replicaSet=${MONGO_AUDIT_REPLICA_SET}&authSource=admin"

exec /opt/mongodb_exporter \
  --collector.diagnosticdata \
  --collector.replicasetstatus \
  --collector.dbstats \
  --collector.topmetrics \
  --collector.currentopmetrics \
  --discovering-mode \
  --mongodb.uri="${MONGO_URI}" \
