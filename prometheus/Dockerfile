ARG BASE_IMG="prom/prometheus:v3.5.0"

FROM "${BASE_IMG}"

ENV CONF_INNER_PATH=/etc/prometheus/prometheus.yaml

COPY --chmod=644 ./prometheus/config.yaml "${CONF_INNER_PATH}"
COPY --chmod=755 ./prometheus/entrypoint.sh /usr/local/bin/

EXPOSE 9090
ENTRYPOINT /usr/local/bin/entrypoint.sh
