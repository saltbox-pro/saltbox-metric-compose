<div align = right>

&ensp;[<kbd> <br> EN <br> </kbd>](./README.md)&ensp;
&ensp;[<kbd> <br> RU <br> </kbd>](./README_RU.md)&ensp;

</div>

---

# Salt.Box Metric Compose

## Содержание

- **[Как запустить](#как-запустить)**
- **[Как включить алерты Grafana](#как-включить-алерты-grafana)**


## Как запустить

- Склонируйте репозиторий [Salt.Box Compose](https://dev.saltbox.pro/saltbox/saltbox-compose/) в отдельный внешний каталог.
- Перейдите в каталог `saltbox-compose`.
- Добавьте в `override.env`:

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

- Запустите систему вспомогательным скриптом:

```sh
sudo ./bin/update_and_run.sh
```

> **ПРИМЕЧАНИЕ** Ошибка `/var/lib/docker/containers: permission denied` при запуске
> обычно означает, что переменные `$METRIC_DOCKER_*` из [`.env`](./.env) нужно
> переопределить.


## Как включить алерты Grafana

1. Задайте настройки SMTP в `override.env`:

```sh
SMTP_HOST='smtp.<CHANGE_ME>.com:465'
SMTP_USER='smtp_user@example.com'
SMTP_FROM_ADDRESS='smtp_user@example.com'
SMTP_ALERT_EMAILS='me@example.com;you@example.co'
```

- `SMTP_FROM_ADDRESS` – адрес отправителя, который будет показан в письмах с алертами
- `SMTP_ALERT_EMAILS` – список адресов получателей через точку с запятой

2. Задайте секрет `grafana_smtp_password` в `saltbox-compose` со значением пароля для `SMTP_HOST`:

```sh
echo -n 'your_smtp_password' > secrets/grafana_smtp_password
```

3. Примените изменения в каталоге `saltbox-compose`.

   - **Если система ещё не запускалась**, секрет будет подхвачен при первом запуске:

     ```sh
     sudo ./bin/update_and_run.sh -l -d
     ```

   - **Если система уже запущена**, секрет монтируется только при старте контейнера, поэтому Grafana нужно перезапустить явно:

     ```sh
     sudo ./bin/sb-compose.sh restart grafana
     ```
