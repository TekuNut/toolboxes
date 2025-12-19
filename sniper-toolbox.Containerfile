FROM registry.gitlab.steamos.cloud/steamrt/sniper/sdk

ENV DEBIAN_FRONTEND=noninteractive

# Install required development packages
RUN apt-get update -y && apt-get install -y direnv libboost-all-dev inotify-tools zsh \
  adwaita-icon-theme avahi-daemon bash-completion bind9-host bind9-libs dbus \
  dialog gnupg2 gtk-update-icon-cache iproute2 iputils-ping keyutils \
  libapparmor1 libatm1 libavahi-core7 libbpf0 libdaemon0 libegl1-mesa \
  libfstrm0 libgail-common libgail18 libgl1-mesa-glx libgtk2.0-0 libgtk2.0-bin \
  libgtk2.0-common libjansson4 libjson-c5 liblmdb0 libmaxminddb0 libmnl0 \
  libnss-mdns libpcap0.8 libprotobuf-c1 librsvg2-2 librsvg2-common \
  libvte-2.91-common libvte-common libxtables12 locales lsof manpages \
  mesa-vulkan-drivers mtr pigz tcpdump traceroute tree \
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

# Install odin
RUN mkdir -p /opt/odin \
  && cd /tmp \
  && curl -LO "https://github.com/odin-lang/Odin/releases/download/dev-2025-12/odin-linux-amd64-dev-2025-12.tar.gz" \
  && tar -xvf ./odin-linux-amd64-dev-2025-12.tar.gz --strip-components=1 -C /opt/odin

ENV PATH="$PATH:/opt/odin"
