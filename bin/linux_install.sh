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
  git clone https://github.com/nodenv/nodenv.git ~/.nodenv
  cd ~/.nodenv && src/configure && make -C src

  # Append to zshrc
  echo 'export PATH="$HOME/.nodenv/bin:$PATH"' >> ~/.zshrc
  echo 'eval "$(nodenv init --no-rehash -)" 2> /dev/null' >> ~/.zshrc
  echo '(nodenv rehash &) 2> /dev/null # background rehash - much faster' >> ~/.zshrc

  # Install latest node version
  export PATH="$HOME/.nodenv/bin:$PATH"
  versions=($(IFS='\n' ; nodenv install -l 2>/dev/null)) # get versions from nodenv
  versions_separated=$(IFS=';' ; echo "${versions[*]}")  # convert to ; separated
  prompt_for_multiselect selected_version "$versions_separated"
  version=$(is_selected "${versions[*]}" "${selected_version[*]}")
  nodenv install $version
  npm install -g --silent yarn
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
