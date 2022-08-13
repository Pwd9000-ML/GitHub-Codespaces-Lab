# You can pick any Debian/Ubuntu-based image. 😊
FROM mcr.microsoft.com/vscode/devcontainers/base:0-bullseye

# [Option] Install zsh
ARG INSTALL_ZSH="true"
# [Option] Upgrade OS packages to their latest versions
ARG UPGRADE_PACKAGES="false"

# Install needed packages and setup non-root user. Use a separate RUN statement to add your own dependencies.
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID
COPY library-scripts/*.sh /tmp/library-scripts/
RUN bash /tmp/library-scripts/common-debian.sh "${INSTALL_ZSH}" "${USERNAME}" "${USER_UID}" "${USER_GID}" "${UPGRADE_PACKAGES}" "true" "true" \
    # Install the Azure CLI
    && bash /tmp/library-scripts/azcli-debian.sh 

# cd into the user directory, download and unzip the github actions runner
RUN cd /home/vscode && mkdir actions-runner && cd actions-runner

#input GitHub runner version argument
ARG RUNNER_VERSION="2.292.0"

RUN curl -O -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz \
    && tar xzf ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz

# install some additional dependencies
#RUN chown -R vscode ~vscode && /home/vscode/actions-runner/bin/installdependencies.sh
RUN /bin/bash /home/vscode/actions-runner/bin/installdependencies.sh

# add over the start.sh script
COPY library-scripts/start.sh start.sh
# Clean up
RUN apt-get clean -y && rm -rf /var/lib/apt/lists/* /tmp/library-scripts


# make the script executable
RUN chmod +x start.sh

# set the user to "vscode" so all subsequent commands are run as the vscode user
#USER vscode


# set the entrypoint to the start.sh script
ENTRYPOINT ["./start.sh"]

