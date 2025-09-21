FROM registry.gitlab.steamos.cloud/steamrt/sniper/sdk

ENV DEBIAN_FRONTEND=noninteractive

# Install required development packages
RUN apt-get install -y direnv libboost-all-dev inotify-tools zsh \
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
  && curl -LO "https://github.com/neovim/neovim-releases/releases/download/v0.11.4/nvim-linux-x86_64.tar.gz" \
  && tar -xvf ./nvim-linux-x86_64.tar.gz --strip-components=1 -C /usr/local \
  && rm ./nvim-linux-x86_64.tar.gz

# Install a newer version of CMake
RUN cd /tmp \
  && curl -LO "https://github.com/Kitware/CMake/releases/download/v4.1.1/cmake-4.1.1-linux-x86_64.sh" \
  && chmod +x ./cmake-4.1.1-linux-x86_64.sh \
  && ./cmake-4.1.1-linux-x86_64.sh --prefix=/usr/local --exclude-sub-dir --skip-license \
  && rm ./cmake-4.1.1-linux-x86_64.sh
