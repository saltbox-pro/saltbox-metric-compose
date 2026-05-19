ARG BASE_IMG="grafana/loki:3.4.5"

FROM ${BASE_IMG}

COPY --chmod=644 ./grafana_loki/config.yaml /etc/loki/config.yaml
COPY --chmod=755 ./bin/base_healthcheck.sh /usr/local/bin/

ENV HEALTHCHECK_ENDPOINT=http://localhost:3100/ready
ENV HEALTHCHECK_TITLE="GET /ready"
ENV HEALTHCHECK_CMD="wget -S -q --tries=1 -O /dev/null \"${HEALTHCHECK_ENDPOINT}\" \
  2>&1 | grep \"HTTP/\""

HEALTHCHECK \
  --interval=60m \
  --start-interval=20s \
  --start-period=120s \
  --timeout=5s \
  CMD /usr/local/bin/base_healthcheck.sh run_check \
    "${HEALTHCHECK_TITLE}" \ 
    sh -c "${HEALTHCHECK_CMD}"

EXPOSE 3100

ENTRYPOINT [ \
  "/usr/bin/loki", \
  "-config.file=/etc/loki/config.yaml", \
  "-config.expand-env=true" \
]
