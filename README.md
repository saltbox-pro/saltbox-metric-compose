# Salt.Box Metric Compose

## How to run

- Get [Salt.Box Compose](https://dev.saltbox.pro/saltbox/saltbox-compose/) to some outer directory.
- Change directory to `saltbox-compose`.
- Add to `override.env`:

```sh
# TODO Check the relative Path to Metric Compose
COMPOSE_FILE="${COMPOSE_FILE}:../saltbox-metric-compose/compose.yaml"
# Optional for development
#COMPOSE_FILE="${COMPOSE_FILE}:../saltbox-metric-compose/compose-backend-dev.yaml"

# TODO Recheck the path
# Multiple values separates by commas
_UPDATE_AND_RUN_EXTRA_ENV_FILES='../saltbox-metric-compose/.env'
# If differs from usual location
#METRIC_OUTER_PATH='../RELATIVE_TO_SALTBOX_COMPOSE'
```

- Optionally add to `override.env` new values for the [`.env`](./.env) file.

- Run the system with the helper script:

```sh
sudo ./bin/update_and_run.sh
```

> **INFO** Error `/var/lib/docker/containers: permission denied` on start
> usually means `$METRIC_DOCKER_*` variables of [`.env`](./.env) should be
> overrided.
