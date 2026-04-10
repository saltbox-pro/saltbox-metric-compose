# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

> Types of changes: Added, Changed, Deprecated, Removed, Fixed, Security.

__Some changes are breaking__. Cleanup Keycloak database before update
if possible and purge browser redirects.

## [Unreleased] - YYYY-MM-DD

### Added

- CI jobs for building images in registry.

### Changed

- Separate services `grafana`, `grafana-loki`, `prometheus`, `promtail`
  into subdirs and backed service images.

### Fixed


### Removed
