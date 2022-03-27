FROM gitpod/workspace-full

USER gitpod

# Flutter
RUN brew tap leoafarias/fvm
RUN brew install fvm
RUN dart pub global activate fvm
RUN fvm install 2.10.3
RUN fvm use 2.10.3
RUN fvm global 2.10.3

# Install custom tools, runtime, etc. using apt-get
# For example, the command below would install "bastet" - a command line tetris clone:
#
# RUN sudo apt-get -q update && \
#     sudo apt-get install -yq bastet && \
#     sudo rm -rf /var/lib/apt/lists/*
#
# More information: https://www.gitpod.io/docs/42_config_docker/