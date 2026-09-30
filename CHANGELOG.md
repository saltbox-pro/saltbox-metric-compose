# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

> Types of changes: Added, Changed, Deprecated, Removed, Fixed, Security.

__Some changes are breaking__. Cleanup Keycloak database before update
if possible and purge browser redirects.


## [x.x.x] - YYYY-MM-DD

### Added

- Individual `METRIC_FRONTEND_IMAGE_TAG` variable
- MongoDB exporter supports replica set of several members via `MONGO_HOSTS`,
  `MONGO_AUDIT_HOSTS` or `MONGO_URI`, `MONGO_AUDIT_URI` variables, every
  member is scraped separately.


### Changed

- MongoDB metrics are scraped by single `mongodb` Prometheus job via exporter
  `/scrapeall`, `instance` label is `host:port` of replica set member instead
  of `Mongo` and `Mongo Audit`.


### Fixed

- Prometheus data is stored in `prometheus_data` volume, previously it was
  written to anonymous volume and lost on container recreation.
- Grafana Loki data and Promtail positions are stored in `grafana_loki_data`
  and `promtail_data` volumes, previously they were written to container
  `/tmp` and lost on container recreation.
- Grafana Loki 7 days retention is applied by compactor, `table_manager`
  retention is ignored for `tsdb` index store and logs were kept forever.

### Removed
- `compose.yaml`: rabbitmq dependency form `saltbox-metric` service


## [0.3.0] - 2026-07-10

### Added

- CI job to validate image tags.
- Grafana alerting rules and provisioning configuration.
- Container liveness, Docker memory, host CPU, host RAM and HTTP 5xx alerts.
- MongoDB metrics exporter.
- Docker and Node Exporter Grafana dashboards.
- Manual for enabling Grafana alerting.

### Changed

- `compose.yaml`: `COMPOSE_FILES` can now be overridden from `.env`.
- `compose.yaml`: set global `ulimits.nofile` and Docker logging limits.
- `compose.yaml`: use `json-file` as the default Docker logging driver.
- Default image tags switched to `dev`.
- Simplified image build process.
- Reorganized Promtail configuration layout.
- cAdvisor: increase Prometheus scrape interval.
- cAdvisor: mount `containerd.sock` for improved metrics collection.
- Grafana dashboards updated.

### Fixed

- CI: fix image build pipeline.
- CI: fix relative path to Prometheus Dockerfile.
- CI: add local build cache directory to `.gitignore`.
- Fix Hadolint issues.
- Fix Grafana `NoData` alert condition.
- Miscellaneous dashboard improvements.

### Removed
