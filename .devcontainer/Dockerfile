FROM debian:bookworm

RUN apt-get update && apt-get dist-upgrade -y
RUN apt-get install -y git \
  python3 \
  pipx \
  gnupg \
  software-properties-common \
  wget

# Install ansible
RUN pipx install --include-deps ansible
# Setup argcomplete for ansible
RUN pipx inject --include-apps ansible argcomplete
RUN activate-global-python-argcomplete --user

# Setup global module access
RUN pipx ensurepath

# Add hashicorp keyrings
RUN wget -O- https://apt.releases.hashicorp.com/gpg | \
  gpg --dearmor | \
  tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
  https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
  tee /etc/apt/sources.list.d/hashicorp.list

# Install terraform
RUN apt-get update && apt-get install -y terraform

# Setup tab completion
RUN terraform -install-autocomplete

# Setup locale
RUN apt-get install -y locales
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen

# environments
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8

# Install packer
RUN apt install -y packer
RUN apt install -y sshpass

# Install LXC
RUN apt-get install -y lxc

# Clean up
RUN apt clean
