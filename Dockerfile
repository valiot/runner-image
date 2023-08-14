FROM summerwind/actions-runner:latest
ARG TARGETARCH
ENV LANG "en_US.UTF-8"
ENV LC_TYPE "en_US.UTF-8"

# Get yarn deb package and install
RUN curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
RUN sudo apt-get update -qq \
  && sudo apt-get install -y yarn

# Get kubectl deb package and install
RUN sudo curl -LO "https://dl.k8s.io/release/$(curl -Ls https://dl.k8s.io/release/stable.txt)/bin/linux/${TARGETARCH}/kubectl" \
  && sudo chmod +x ./kubectl \
  && sudo mv ./kubectl /usr/local/bin/kubectl

# Install dependencies for Cypress https://docs.cypress.io/guides/continuous-integration/introduction#UbuntuDebian
RUN sudo apt-get install -y libgtk2.0-0 libgtk-3-0 libgbm-dev libnotify-dev libgconf-2-4 libnss3 libxss1 libasound2 libxtst6 xauth xvfb
# Missing deps for Cypress
RUN sudo apt-get install -y xdg-utils