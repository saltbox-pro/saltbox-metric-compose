ARG BASE_IMG=percona/mongodb_exporter:0.51.0
FROM ${BASE_IMG} AS base

FROM alpine:3.23.4

COPY --from=base /mongodb_exporter /opt/mongodb_exporter
COPY --chmod=755 ./mongo_exporter/entrypoint.sh /usr/local/bin/

ENV MONGO_USER=''
ENV MONGO_HOSTNAME=''
ENV MONGO_AUDIT_HOSTNAME=''
ENV MONGO_REPLICA_SET=''
ENV MONGO_AUDIT_REPLICA_SET=''

EXPOSE 9216

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
