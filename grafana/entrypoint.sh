#! /bin/sh

GF_SMTP_PASSWORD_PATH=/run/secrets/grafana_smtp_password
GF_CONTACT_POINTS_TMPL_PATH=/etc/grafana/provisioning/alerting/contact-points.yaml.tmpl
GF_CONTACT_POINTS_OUT_PATH=/etc/grafana/provisioning/alerting/contact-points.yaml

if [ -e "${GF_SMTP_PASSWORD_PATH}" ]; then
  GF_SMTP_PASSWORD=$(cat "${GF_SMTP_PASSWORD_PATH}")
  export GF_SMTP_PASSWORD
fi

envsubst < "${GF_CONTACT_POINTS_TMPL_PATH}" > "${GF_CONTACT_POINTS_OUT_PATH}"
/run.sh
