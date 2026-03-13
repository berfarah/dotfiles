# macOS helpers — extracted from oh-my-zsh macos plugin

function _macos_get_frontmost_app() {
  osascript 2>/dev/null <<EOF
    tell application "System Events"
      name of first item of (every process whose frontmost is true)
    end tell
EOF
}

# Open current directory (or arguments) in Finder
function ofd {
  if (( ! $# )); then
    open "$PWD"
  else
    open "$@"
  fi
}

# Print Finder directory
function pfd() {
  osascript 2>/dev/null <<EOF
    tell application "Finder"
      return POSIX path of (insertion location as alias)
    end tell
EOF
}

# Print Finder selection
function pfs() {
  osascript 2>/dev/null <<EOF
    set output to ""
    tell application "Finder" to set the_selection to selection
    set item_count to count the_selection
    repeat with item_index from 1 to count the_selection
      if item_index is less than item_count then set the_delimiter to "\n"
      if item_index is item_count then set the_delimiter to ""
      set output to output & ((item item_index of the_selection as alias)'s POSIX path) & the_delimiter
    end repeat
EOF
}

# cd to Finder directory
function cdf() {
  cd "$(pfd)"
}

# pushd to Finder directory
function pushdf() {
  pushd "$(pfd)"
}

# Open a new terminal tab in the current directory
function tab() {
  local command="cd \\\"$PWD\\\"; clear"
  (( $# > 0 )) && command="${command}; $*"

  local the_app=$(_macos_get_frontmost_app)

  if [[ "$the_app" == 'Terminal' ]]; then
    osascript >/dev/null <<EOF
      tell application "System Events"
        tell process "Terminal" to keystroke "t" using command down
      end tell
      tell application "Terminal" to do script "${command}" in front window
EOF
  elif [[ "$the_app" == 'iTerm2' ]]; then
    osascript <<EOF
      tell application "iTerm2"
        tell current window
          create tab with default profile
          tell current session to write text "${command}"
        end tell
      end tell
EOF
  elif [[ "$the_app" == 'ghostty' ]]; then
    osascript >/dev/null <<EOF
      tell application "System Events"
        tell process "Ghostty" to keystroke "t" using command down
      end tell
EOF
  else
    echo "$0: unsupported terminal app: $the_app" >&2
    return 1
  fi
}

# Split horizontally
function split_tab() {
  local command="cd \\\"$PWD\\\"; clear"
  (( $# > 0 )) && command="${command}; $*"

  local the_app=$(_macos_get_frontmost_app)

  if [[ "$the_app" == 'iTerm2' ]]; then
    osascript <<EOF
      tell application "iTerm2"
        tell current session of first window
          set newSession to (split horizontally with same profile)
          tell newSession
            write text "${command}"
            select
          end tell
        end tell
      end tell
EOF
  elif [[ "$the_app" == 'ghostty' ]]; then
    osascript >/dev/null <<EOF
      tell application "System Events"
        tell process "Ghostty" to keystroke "d" using command down
      end tell
EOF
  else
    echo "$0: unsupported terminal app: $the_app" >&2
    return 1
  fi
}

# Split vertically
function vsplit_tab() {
  local command="cd \\\"$PWD\\\"; clear"
  (( $# > 0 )) && command="${command}; $*"

  local the_app=$(_macos_get_frontmost_app)

  if [[ "$the_app" == 'iTerm2' ]]; then
    osascript <<EOF
      tell application "iTerm2"
        tell current session of first window
          set newSession to (split vertically with same profile)
          tell newSession
            write text "${command}"
            select
          end tell
        end tell
      end tell
EOF
  elif [[ "$the_app" == 'ghostty' ]]; then
    osascript >/dev/null <<EOF
      tell application "System Events"
        tell process "Ghostty" to keystroke "D" using command down
      end tell
EOF
  else
    echo "$0: unsupported terminal app: $the_app" >&2
    return 1
  fi
}
