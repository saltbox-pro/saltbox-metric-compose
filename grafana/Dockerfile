ARG BASE_IMG="grafana/grafana:12.3.2-security-01"

FROM ${BASE_IMG}

USER root
RUN apk add --no-cache gettext
USER grafana

ARG MAIN_DASHBOARD_OUTER_PATH=./grafana/grafana.d/dashboards/dashboard.json
ARG MAIN_DASHBOARD_INNER_PATH=/etc/grafana/provisioning/dashboards/dashboard.json

ARG CONTACT_POINTS_TMPL_OUTER_PATH=./grafana/grafana.d/alerting/contact-points.yaml.tmpl
ARG CONTACT_POINTS_TMPL_INNER_PATH=/etc/grafana/provisioning/alerting/contact-points.yaml.tmpl

ARG DASHBOARDS_OUTER_PATH=./grafana/grafana.d/dashboards/dashboard.yaml
ARG DASHBOARDS_INNER_PATH=/etc/grafana/provisioning/dashboards/dashboard.yaml

ARG DATASOURCES_OUTER_PATH=./grafana/grafana.d/datasources.yaml
ARG DATASOURCES_INNER_PATH=/etc/grafana/provisioning/datasources/datasources.yaml

COPY --chmod=644 "${MAIN_DASHBOARD_OUTER_PATH}" \
    "${MAIN_DASHBOARD_INNER_PATH}"

COPY --chmod=644 "${CONTACT_POINTS_TMPL_OUTER_PATH}" \
    "${CONTACT_POINTS_TMPL_INNER_PATH}"

COPY --chmod=444 "${DASHBOARDS_OUTER_PATH}" \
    "${DASHBOARDS_INNER_PATH}"

COPY --chmod=444 "${DATASOURCES_OUTER_PATH}" \
    "${DATASOURCES_INNER_PATH}"

COPY --chmod=755 ./grafana/entrypoint.sh /usr/local/bin/
COPY --chmod=755 ./bin/base_healthcheck.sh /usr/local/bin/

ENV HEALTHCHECK_ENDPOINT=http://localhost:3000/api/health
ENV HEALTHCHECK_TITLE="GET /api/health"

HEALTHCHECK \
  --interval=60m \
  --start-interval=5s \
  --start-period=30s \
  --timeout=10s \
  CMD /usr/local/bin/base_healthcheck.sh run_check \
      "${HEALTHCHECK_TITLE}" curl -fsS "${HEALTHCHECK_ENDPOINT}"

EXPOSE 3000

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
