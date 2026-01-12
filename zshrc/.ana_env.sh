 # not backed up by git - contains local environment variables
source ~/.ana_variables

if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init - zsh)"
    eval "$(pyenv virtualenv-init -)"
fi

export LDFLAGS="-L/opt/homebrew/opt/mysql-client/lib"
export CPATH="$HOME/src/concord"
export PKG_CONFIG_PATH="/opt/homebrew/opt/mysql-client/lib/pkgconfig:$PKG_CONFIG_PATH"
export PIPX_DEFAULT_PYTHON="$HOME/.pyenv/versions/3.9.25/bin/python"
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"
# export PYTHONPATH="packages/anaplan-integration-apis:packages/cloudworks-anaplan-adapter:packages/cloudworks-anaplan-connector:packages/cloudworks-api:packages/cloudworks-predictiveinsights-adapter:packages/cloudworks-predictiveinsights-connector:packages/cloudworks-runtime:packages/cloudworks-sfdc-adapter:packages/cloudworks-sfdc-connector:packages/concord-airflow-dags:packages/concord-audit:packages/concord-auth:packages/concord-celery:packages/concord-cloud:packages/concord-common:packages/concord-configuration:packages/concord-external-sdks:packages/concord-key-management:packages/concord-notification:packages/concord-orm:packages/planiq-integration-apis:services/airflow:services/api:services/async-executor:services/dag-file-generator:services/external-cloud-gateway:services/job-manager"
