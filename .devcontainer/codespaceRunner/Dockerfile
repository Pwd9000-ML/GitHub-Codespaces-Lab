# base image
FROM mcr.microsoft.com/vscode/devcontainers/base:bullseye

# cd into the user directory, download and unzip the github actions runner
RUN cd /home/vscode && mkdir actions-runner && cd actions-runner

#input GitHub runner version argument
#ARG RUNNER_VERSION="2.292.0"

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends curl ca-certificates \
    && bash -c "$(curl -fsSL "https://github.com/actions/runner/releases/download/v2.295.0/actions-runner-linux-x64-2.295.0.tar.gz")" \
    && tar xvzf ./actions-runner-linux-x64-2.295.0.tar.gz \
    && apt-get clean -y && rm -rf /var/lib/apt/lists/*

# install some additional dependencies
#RUN chown -R vscode ~vscode && /home/vscode/actions-runner/bin/installdependencies.sh
RUN /bin/bash /home/vscode/actions-runner/bin/installdependencies.sh

# add over the start.sh script
COPY scripts/start.sh start.sh

# make the script executable
RUN chmod +x start.sh

# set the user to "vscode" so all subsequent commands are run as the vscode user
USER vscode

# set the entrypoint to the start.sh script
ENTRYPOINT ["./start.sh"]