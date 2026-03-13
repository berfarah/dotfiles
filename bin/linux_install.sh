#!/bin/bash

# Include function to get select
echo "$(dirname "$0")/select.sh"
source "$(dirname "$0")/select.sh"

echo "Installing defaults:"
sudo apt install -y fzf \
                    ripgrep \
                    htop \
                    tree \
                    tmux \
                    curl \
                    ca-certificates \
                    wget \
                    make \
                    zsh

OPTIONS_VALUES=(go   node neovim docker)
DEFAULTS=(      true true true   true)

for i in "${!OPTIONS_VALUES[@]}"; do
  OPTIONS_STRING+="${OPTIONS_VALUES[$i]} (${OPTIONS_LABELS[$i]});"
done

prompt_for_multiselect SELECTED "$(IFS=';' ; echo "${OPTIONS_VALUES[*]}")" "$(IFS=';' ; echo "${DEFAULTS[*]}")"
CHECKED=$(is_selected "${OPTIONS_VALUES[*]}" "${SELECTED[*]}")

if [[ " ${CHECKED[@]} " =~ " go " ]]; then
  sudo add-apt-repository ppa:longsleep/golang-backports
  sudo apt update
  sudo apt install -y golang-go
fi

if [[ " ${CHECKED[@]} " =~ " node " ]]; then
  # Install mise if not present
  if ! command -v mise &> /dev/null; then
    curl https://mise.run | sh
    echo 'eval "$(~/.local/bin/mise activate bash)"' >> ~/.bashrc
    echo 'eval "$(~/.local/bin/mise activate zsh)"' >> ~/.zshrc
    export PATH="$HOME/.local/bin:$PATH"
  fi

  mise use --global node@23.7.0
fi

if [[ " ${CHECKED[@]} " =~ " neovim " ]]; then
  sudo add-apt-repository ppa:neovim-ppa/unstable
  sudo apt update
  sudo apt install -y neovim python3 python3-pip python3-neovim
fi

if [[ " ${CHECKED[@]} " =~ " docker " ]]; then
  sudo install -m 0755 -d /etc/apt/keyrings
  sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
  sudo chmod a+r /etc/apt/keyrings/docker.asc

  # Add the repository to Apt sources:
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt-get update

  sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
fi
