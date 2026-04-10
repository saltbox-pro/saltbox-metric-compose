#! /bin/sh

/bin/prometheus \
  --config.file="${CONF_INNER_PATH}" \
  --web.external-url="https://${WEB_SERVER_OUTER_SOCKET}/prometheus/" \
  --web.route-prefix=/prometheus/
