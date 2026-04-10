ARG BASE_IMG="grafana/promtail:3.4.5"

FROM "${BASE_IMG}"

COPY --chmod=644 ./promtail/config.yaml /etc/promtail/config.yaml

EXPOSE 9080

ENTRYPOINT [ \
  "/usr/bin/promtail", \
  "-config.file=/etc/promtail/config.yaml", \
  "-config.expand-env=true" \
]
