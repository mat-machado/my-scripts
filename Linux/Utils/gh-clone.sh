#!/bin/bash

RepoList=("athena-salesforce-integration-job" "code-metadata-update-tool" "data-airflow-dags" "data-airflow-stack" data-dms-stack "data-jobs" "data-platform-adhoc-analysis"
    "data-lake-quality-check" "gh-runner" "gh-runner-check-stuck-stack" "gh-runner-stack" "gh-runner-task-action" "gh-sysbox-image-builder-stack" "mrr-forecast-model-job"
    "pd-airflow-lib" "pd-backstage" "pd-backstage-templates" "pd-github-billing-job" "pdlytics-stack" "pd-roles-stack" "pd-sso")

cd /home/pd-mateus/Documents/Git

for repo in "${RepoList[@]}"; do
    echo "Cloning the repo $repo..."
    gh repo clone PasseiDireto/$repo
    echo ""
done
