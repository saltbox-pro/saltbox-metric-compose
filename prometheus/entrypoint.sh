#! /bin/sh

/bin/prometheus \
  --config.file="${CONF_INNER_PATH}" \
  --storage.tsdb.retention.time="${STORAGE_RETENTION_TIME}" \
  --web.external-url="https://${WEB_SERVER_OUTER_SOCKET}/prometheus/" \
  --web.route-prefix=/prometheus/
