#!/bin/bash

RepoList=("athena-salesforce-integration-job" "data-airflow-stack" "data-jobs" "data-platform-adhoc-analysis" "gh-runner"
    "gh-runner-stack" "gh-sysbox-image-builder-stack" "mrr-forecast-model-job" "onboarding-mateus" "pd-airflow-lib" "pdlytics-stack")

cd /home/matvieira/Documents/Git

for repo in "${RepoList[@]}"; do
    echo "Cloning the repo $repo..."
    gh repo clone PasseiDireto/$repo
    echo ""
done
