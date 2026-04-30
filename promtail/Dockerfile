ARG BASE_IMG="grafana/promtail:3.4.5"

FROM ${BASE_IMG}

RUN \
  --mount=type=cache,target=/var/cache/apt,sharing=locked \
  --mount=type=cache,target=/var/lib/apt/lists,sharing=locked \
  apt-get update && apt-get install --no-install-recommends -y gettext-base=0.21-14ubuntu2

COPY --chmod=755 ./promtail/entrypoint.sh /usr/local/bin/
COPY --chmod=644 ./promtail/promtail.d/config.yaml.tmpl /etc/promtail/config.yaml.tmpl
COPY --chmod=644 ./promtail/promtail.d/regex_expression/*.txt /etc/promtail/regex_expression/

EXPOSE 9080

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
