FROM summerwind/actions-runner:latest
ARG TARGETARCH
# Get yarn deb package and install
RUN curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
RUN sudo apt-get update -qq \
  && sudo apt-get install -y yarn

# Get kubectl deb package and install
RUN sudo curl -LO "https://dl.k8s.io/release/$(curl -Ls https://dl.k8s.io/release/stable.txt)/bin/darwin/${TARGETARCH}/kubectl" \
  && sudo chmod +x ./kubectl \
  && sudo mv ./kubectl /usr/local/bin/kubectl
