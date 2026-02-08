cask_args appdir: '/Applications'

# =========================================================
# Quicklook extensions
# =========================================================
if !ENV["ENABLE_QUICKLOOK"].nil?
  cask 'qlmarkdown'
  cask 'qlprettypatch'
  cask 'qlstephen'
  cask 'quicklook-csv'
  cask 'quicklook-json'
  cask 'webpquicklook'
end

cask 'font-source-code-pro'
cask 'font-sauce-code-pro-nerd-font'

# =========================================================
# Development
# =========================================================

# Development tools
brew 'wget'
brew 'bcrypt'
brew 'fzf'
brew 'git'
brew 'htop'
cask 'karabiner-elements'
brew 'neovim'
brew 'tree-sitter'
brew 'tree-sitter-cli'
system 'pip3 install neovim'
brew 'p7zip'
brew 'ripgrep'
brew 'tree'
brew 'gh'

if !ENV["WORK_MACHINE"].nil?
  cask 'aws-vault'
end

# Languages
brew 'go'
brew 'gopls'
brew 'lua-language-server'
brew 'node'
system 'npm i -g vscode-langservers-extracted'
brew 'python'

# Tools that require passwords
cask 'docker-desktop'
cask 'claude-code'

# =========================================================
# Applications
# =========================================================
cask 'raycast'
cask 'iterm2'
cask 'spotify'
cask 'elgato-wave-link'
cask 'elgato-stream-deck'
cask 'elgato-control-center'
