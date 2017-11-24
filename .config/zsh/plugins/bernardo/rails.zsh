# Rails command uses binstubs or bundler
function _rails_command () {
  if [ -e "bin/rails" ]; then
    bin/rails $@
  elif type bundle &> /dev/null && [ -e "Gemfile" ]; then
    bundle exec rails $@
  else
    command rails $@
  fi
}
alias rails='_rails_command'

# Rake command uses binstubs or bundler
function _rake_command () {
  if [ -e "bin/rake" ]; then
    bin/rake $@
  elif type bundle &> /dev/null && [ -e "Gemfile" ]; then
    bundle exec rake $@
  else
    command rake $@
  fi
}
alias rake='_rake_command'
