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
#COMPOSE_FILE="${COMPOSE_FILE}:../saltbox-metric-compose/compose-dev.yaml"

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


## How to enable Grafana alerting

1. Edit SMTP configuration in `override.env`:

```sh
SMTP_HOST='smtp.<CHANGE_ME>.com:465'
SMTP_USER='smtp_user@example.com'
SMTP_FROM_ADDRESS='smtp_user@example.com'
SMTP_ALERT_EMAILS='me@example.com;you@example.co'
```

- `SMTP_FROM_ADDRESS` — the sender address shown in alert emails
- `SMTP_ALERT_EMAILS` — semicolon-separated list of recipient addresses

2. Set `grafana_smtp_password` secret in `saltbox-compose` to the password for `SMTP_HOST`:

```sh
echo -n 'your_smtp_password' > secrets/grafana_smtp_password
```

3. Apply the changes on `saltbox-compose` directory.

   - **If the system has not been started yet** — the secret will be picked up on first start:

     ```sh
     sudo ./bin/update_and_run.sh -l -d
     ```

   - **If the system is already running** — the secret is mounted at container start, so Grafana must be explicitly restarted:

     ```sh
     sudo ./bin/sb-compose.sh restart grafana
     ```
