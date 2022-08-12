ARG RUNNER_VERSION
ARG VARIANT

# base image
FROM mcr.microsoft.com/vscode/devcontainers/base:0-${VARIANT}

#input GitHub runner version argument
ENV DEBIAN_FRONTEND=noninteractive

LABEL Author="Marcel L"
LABEL Email="pwd9000@hotmail.co.uk"
LABEL GitHub="https://github.com/Pwd9000-ML"
LABEL BaseImage=${VARIANT}
LABEL RunnerVersion=${RUNNER_VERSION}

# update the base packages
RUN apt-get update -y && apt-get upgrade -y

# [Optional] Uncomment this section to install additional OS packages.
RUN apt-get install -y --no-install-recommends \
    curl nodejs wget unzip vim git jq build-essential libssl-dev libffi-dev python3 python3-venv python3-dev python3-pip

# cd into the user directory, download and unzip the github actions runner
RUN cd /home/vscode && mkdir actions-runner && cd actions-runner \
    && curl -O -L https://github.com/actions/runner/releases/download/v2.295.0/actions-runner-linux-x64-2.295.0.tar.gz \
    && tar xzvf ./actions-runner-linux-x64-2.295.0.tar.gz

# install some additional dependencies
RUN chown -R vscode ~vscode && /home/vscode/actions-runner/bin/installdependencies.sh

# add over the start.sh script
ADD scripts/start.sh start.sh

# make the script executable
RUN chmod +x start.sh

# set the user to "docker" so all subsequent commands are run as the docker user
USER vscode

# set the entrypoint to the start.sh script
ENTRYPOINT ["./start.sh"]