#! /bin/bash

set -e

declare -r config_tmpl_path=/etc/promtail/config.yaml.tmpl
declare -r config_out_path=/etc/promtail/config.yaml
declare -r base_regex_path=/etc/promtail/regex_expression

RABBITMQ_REGEX_EXPRESSION=$(cat "${base_regex_path}/rabbitmq_regex.txt")
MONGO_REGEX_EXPRESSION=$(cat "${base_regex_path}/mongo_regex.txt")
METRIC_REGEX_EXPRESSION=$(cat "${base_regex_path}/metric_regex.txt")

export RABBITMQ_REGEX_EXPRESSION MONGO_REGEX_EXPRESSION METRIC_REGEX_EXPRESSION

envsubst < "${config_tmpl_path}" > "${config_out_path}"

/usr/bin/promtail \
  -config.file=${config_out_path} \
  -config.expand-env=true
