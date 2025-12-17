 # not backed up by git - contains local environment variables
source ~/.ana_variables

if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init - zsh)"
    eval "$(pyenv virtualenv-init -)"
fi

export CPATH="$HOME/src/concord"
export PKG_CONFIG_PATH="/opt/homebrew/opt/mysql-client/lib/pkgconfig:$PKG_CONFIG_PATH"
export PIPX_DEFAULT_PYTHON="$HOME/.pyenv/versions/3.9.25/bin/python"
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"
export PYTHONPATH="packages/anaplan-integration-apis:packages/cloudworks-anaplan-adapter:packages/cloudworks-anaplan-connector:packages/cloudworks-api:packages/cloudworks-predictiveinsights-adapter:packages/cloudworks-predictiveinsights-connector:packages/cloudworks-runtime:packages/cloudworks-sfdc-adapter:packages/cloudworks-sfdc-connector:packages/concord-airflow-dags:packages/concord-audit:packages/concord-auth:packages/concord-celery:packages/concord-cloud:packages/concord-common:packages/concord-configuration:packages/concord-external-sdks:packages/concord-key-management:packages/concord-notification:packages/concord-orm:packages/planiq-integration-apis:services/airflow:services/api:services/async-executor:services/dag-file-generator:services/external-cloud-gateway:services/job-manager"

install_py_deps() {
  # Install dependencies for the main 'packages' directory
  echo "Installing dependencies for 'packages'..."
  if pushd packages &>/dev/null; then
    pip install -r requirements.txt -r requirements/dev-requirements.txt
    popd
  else
    echo "Directory 'packages' not found."
    return 1
  fi

  # Install dependencies for all 'services' subdirectories
  echo "Installing dependencies for 'services'..."
  if pushd services &>/dev/null; then
    find . -name 'external-requirements.txt' | xargs -n 1 -P 5 pip install -r
    find . -name 'requirements.txt' | xargs -n 1 -P 5 pip install -r
    find . -name 'dev-requirements.txt' | xargs -n 1 -P 5 pip install -r
    popd
  else
    echo "Directory 'services' not found."
    return 1
  fi

  echo "All Python dependencies installed."
}
