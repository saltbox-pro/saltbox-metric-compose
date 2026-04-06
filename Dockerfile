ARG GRAFANA_BASE_IMG="grafana/grafana:12.3.2-security-01"

FROM "${GRAFANA_BASE_IMG}"

ARG GF_OUTER_DASHBOARD_CONFIG="./metric.d/grafana/dashboards/dashboard.json"
ARG GF_OUTER_DASHBOARDS_CONFIG="./metric.d/grafana/dashboards/dashboard.yaml"
ARG GF_OUTER_DATASOURCES_CONFIG="./metric.d/grafana/datasources/datasources.yaml"

ENV GF_DASHBOARDS_DEFAULT_HOME_DASHBOARD_PATH="/etc/grafana/provisioning/dashboards/dashboard.json"

COPY --chmod=644 "${GF_OUTER_DASHBOARD_CONFIG}" \
    "${GF_DASHBOARDS_DEFAULT_HOME_DASHBOARD_PATH}"

COPY --chmod=444 "${GF_OUTER_DASHBOARDS_CONFIG}" \
    "/etc/grafana/provisioning/dashboards/dashboard.yaml"

COPY --chmod=444 "${GF_OUTER_DATASOURCES_CONFIG}" \
    "/etc/grafana/provisioning/datasources/datasources.yaml"

EXPOSE 3000
CMD [ "/run.sh" ]
