FROM summerwind/actions-runner:latest
ARG TARGETARCH
ENV LANG="en_US.UTF-8"
ENV LC_TYPE="en_US.UTF-8"

RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource.gpg.key | sudo apt-key add -
RUN echo "deb https://deb.nodesource.com/node_20.x $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/nodesource.list

# Update package list and install Node.js and npm
RUN sudo apt-get update -qq && sudo apt-get install -y nodejs

# Get yarn deb package and install
RUN curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
RUN sudo apt-get update -qq \
  && sudo apt-get install -y yarn

# Install Azure cli
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# Get kubectl deb package and install
RUN sudo curl -LO "https://dl.k8s.io/release/$(curl -Ls https://dl.k8s.io/release/stable.txt)/bin/linux/${TARGETARCH}/kubectl" \
  && sudo chmod +x ./kubectl \
  && sudo mv ./kubectl /usr/local/bin/kubectl

# Install dependencies for Cypress https://docs.cypress.io/guides/continuous-integration/introduction#UbuntuDebian
RUN sudo apt-get install -y libgtk2.0-0 libgtk-3-0 libgbm-dev libnotify-dev libgconf-2-4 libnss3 libxss1 libasound2 libxtst6 xauth xvfb
# Missing deps for Cypress
RUN sudo apt-get install -y xdg-utils
# Missing deps for GitHub CLI
RUN sudo apt-get install -y hub

# Install GitHub CLI
RUN (type -p wget >/dev/null || (sudo apt update && sudo apt-get install wget -y)) \
  && sudo mkdir -p -m 755 /etc/apt/keyrings \
  && wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
  && sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
  && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
  && sudo apt update \
  && sudo apt install gh -y

# install python and pipx
RUN sudo apt-get install -y python3 python3-pip

# install poetry
RUN pip3 install poetry