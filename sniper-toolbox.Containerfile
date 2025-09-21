FROM registry.gitlab.steamos.cloud/steamrt/sniper/sdk

ENV DEBIAN_FRONTEND=noninteractive

# Install required development packages
RUN apt-get install -y direnv libboost-all-dev inotify-tools zsh \
  && apt-get remove -y cmake \
  && apt-get clean

# Install zellij
RUN cd /tmp \
  && curl -LO "https://github.com/zellij-org/zellij/releases/download/v0.43.1/zellij-x86_64-unknown-linux-musl.tar.gz" \
  && tar -xvf ./zellij-x86_64-unknown-linux-musl.tar.gz \
  && chmod +x ./zellij \
  && mv ./zellij /usr/local/bin/zellij \
  && rm ./zellij-x86_64-unknown-linux-musl.tar.gz

# Install neovim
RUN cd /tmp \
  && curl -LO "https://github.com/neovim/neovim-releases/releases/download/v0.10.4/nvim-linux-x86_64.deb" \
  && apt-get install -y ./nvim-linux-x86_64.deb \
  && rm ./nvim-linux-x86_64.deb

# Install a newer version of CMake
RUN cd /tmp \
  && curl -LO "https://github.com/Kitware/CMake/releases/download/v4.1.1/cmake-4.1.1-linux-x86_64.sh" \
  && chmod +x ./cmake-4.1.1-linux-x86_64.sh \
  && ./cmake-4.1.1-linux-x86_64.sh --prefix=/usr/local --exclude-sub-dir --skip-license \
  && rm ./cmake-4.1.1-linux-x86_64.sh
