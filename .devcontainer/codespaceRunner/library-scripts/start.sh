#!/bin/bash

GH_OWNER=$GH_OWNER
GH_REPOSITORY=$GH_REPOSITORY
GH_TOKEN=$GH_TOKEN

HOSTNAME=$(hostname)
RUNNER_SUFFIX="runner"
RUNNER_NAME="${HOSTNAME}-${RUNNER_SUFFIX}"
USER_NAME_LABEL=$(git config --get user.name)
REPO_NAME_LABEL="$GH_REPOSITORY"

REG_TOKEN=$(curl -sX POST -H "Accept: application/vnd.github.v3+json" -H "Authorization: token ${GH_TOKEN}" https://api.github.com/repos/${GH_OWNER}/${GH_REPOSITORY}/actions/runners/registration-token | jq .token --raw-output)

/home/vscode/actions-runner/config.sh --unattended --url https://github.com/${GH_OWNER}/${GH_REPOSITORY} --token ${REG_TOKEN} --name ${RUNNER_NAME}  --labels ${USER_NAME_LABEL},${REPO_NAME_LABEL}

cleanup() {
    echo "Removing runner..."
    /home/vscode/actions-runner/config.sh remove --unattended --token ${REG_TOKEN}
}

trap 'cleanup; exit 130' INT
trap 'cleanup; exit 143' TERM
trap 'cleanup' SIGINT SIGTERM

/home/vscode/actions-runner/run.sh & wait $!