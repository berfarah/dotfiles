#!/usr/bin/osascript

# Bounds: {top left x, top left y, width, height}
# Finder bar is 25 pixels high, y should have 25 offset

tell application "System Events"
  tell application "Firefox Developer Edition"
    repeat with app_window in windows
      # Filter out extensions and other non-windows
      if (name of app_window) is not "" and (miniaturizable of app_window) is true
        set coords to get bounds of app_window
        set bounds of app_window to {-1,25,1146,1440}
      end if
    end repeat
  end

  tell application process "Slack"
    set size of window 1 to {1146,707}
    set position of window 1 to {2293,25}
  end tell

  tell application process "Superhuman"
    set size of window 1 to {1146,707}
    set position of window 1 to {2293,733}
  end tell
end
