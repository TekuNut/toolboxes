FROM registry.gitlab.steamos.cloud/steamrt/steamrt4/sdk

ENV DEBIAN_FRONTEND=noninteractive

# Install required development packages
RUN apt-get update -y && apt-get install -y direnv libboost-all-dev inotify-tools zsh \
  adwaita-icon-theme avahi-daemon bash-completion bind9-host bind9-libs dbus \
  clangd clang-tidy \
  dialog gnupg2 gtk-update-icon-cache iproute2 iputils-ping keyutils \
  libapparmor1 libatm1 libavahi-core7 libdaemon0 \
  libfstrm0 libgail-common libgail18 libgtk2.0-0 libgtk2.0-bin \
  libgtk2.0-common libjansson4 libjson-c5 liblmdb0 libmaxminddb0 libmnl0 \
  libnss-mdns libpcap0.8 libprotobuf-c1 librsvg2-2 librsvg2-common \
  libvte-2.91-common libvte-common libxtables12 locales lsof manpages \
  mesa-vulkan-drivers mtr nodejs npm pigz ripgrep tcpdump traceroute tree \
  && apt-get clean

# Install zellij
RUN cd /tmp \
  && curl -LO "https://github.com/zellij-org/zellij/releases/download/v0.43.1/zellij-x86_64-unknown-linux-musl.tar.gz" \
  && tar -xf ./zellij-x86_64-unknown-linux-musl.tar.gz \
  && chmod +x ./zellij \
  && mv ./zellij /usr/local/bin/zellij \
  && rm ./zellij-x86_64-unknown-linux-musl.tar.gz

# Install neovim
RUN cd /tmp \
  && curl -LO "https://github.com/neovim/neovim-releases/releases/download/v0.11.4/nvim-linux-x86_64.tar.gz" \
  && tar -xf ./nvim-linux-x86_64.tar.gz --strip-components=1 -C /usr/local \
  && rm ./nvim-linux-x86_64.tar.gz

# Install odin
RUN mkdir -p /opt/odin \
  && cd /tmp \
  && curl -LO "https://github.com/odin-lang/Odin/releases/download/dev-2025-12/odin-linux-amd64-dev-2025-12.tar.gz" \
  && tar -xf ./odin-linux-amd64-dev-2025-12.tar.gz --strip-components=1 -C /opt/odin \
  && rm ./odin-linux-amd64-dev-2025-12.tar.gz

# Install zig
RUN mkdir -p /opt/zig \
  && cd /tmp \
  && curl -LO "https://ziglang.org/download/0.15.2/zig-x86_64-linux-0.15.2.tar.xz" \
  && tar -xf ./zig-x86_64-linux-0.15.2.tar.xz --strip-components=1 -C /opt/zig \
  && rm ./zig-x86_64-linux-0.15.2.tar.xz

# Install ZLS
RUN cd /tmp \
  && curl -LO "https://builds.zigtools.org/zls-x86_64-linux-0.15.1.tar.xz" \
  && tar -C /usr/local/bin/ -xf zls-x86_64-linux-0.15.1.tar.xz zls \
  && rm ./zls-x86_64-linux-0.15.1.tar.xz

ENV PATH="$PATH:/opt/odin:/opt/zig"
