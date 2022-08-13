# base image
FROM mcr.microsoft.com/vscode/devcontainers/base:bullseye

# cd into the user directory, download and unzip the github actions runner
RUN cd /home/vscode && mkdir actions-runner && cd actions-runner

#input GitHub runner version argument
ARG RUNNER_VERSION="2.292.0"
ENV DEBIAN_FRONTEND=noninteractive

RUN bash -c "$(curl -fsSL "https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz")"
RUN tar xvzf ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz

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