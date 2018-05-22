#!/bin/bash

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.osx` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

############################################################################
# General UI/UX                                                            #
############################################################################

echo "Please type in your desired computer name followed by [ENTER]"
read compname

if [ -n "$compname" ]; then
  # Set computer name (as done via System Preferences → Sharing)
  sudo scutil --set ComputerName $compname
  sudo scutil --set LocalHostName $compname
  sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string $compname
fi

# Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "

# Dark mode
defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"

# Check for software updates daily instead of weekly
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# Download newly available updates in background
defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1

# Install System data files & security updates
defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1

# Turn on app auto-update
defaults write com.apple.commerce AutoUpdate -bool true

# Always show scrollbars
defaults write NSGlobalDomain AppleShowScrollBars -string "WhenScrolling"
# Possible values: `WhenScrolling`, `Automatic` and `Always`

# Menu bar: show remaining battery time (on pre-10.8); hide percentage
defaults write com.apple.menuextra.battery ShowPercent -string "NO"

# General: Enable save documents to iCloud
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# General: automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# General: enable the "Are you sure you want to open this application?" dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Remove duplicates in the “Open With” menu (also see `lscleanup` alias)
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user

# Restart automatically if the computer freezes
systemsetup -setrestartfreeze on

############################################################################
# Trackpad, mouse, keyboard, Bluetooth accessories, and input              #
############################################################################

# Trackpad: enable tap to click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# General: enable "natural" (Lion-style) scrolling
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool true

# General: Disable cursor magnification on shake (El Capitan+)
defaults write NSGlobalDomain CGDisableCursorLocationMagnification -bool true

# Enable full keyboard access for all controls (tab through dialogue)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# General: enable scroll gesture with the Ctrl (^) modifier key to zoom
defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144

# General: enable press-and-hold for keys instead of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 10

# General: automatically illuminate built-in MacBook keyboard in low light
defaults write com.apple.BezelServices kDim -bool false

# Set localization language and units
defaults write NSGlobalDomain AppleLanguages -array "en"
defaults write NSGlobalDomain AppleLocale -string "en_US@currency=USD"
defaults write NSGlobalDomain AppleTemperatureUnit -string "Celsius"
defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
defaults write NSGlobalDomain AppleMetricUnits -bool true

# General: enable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool true

# General: disable smart quotes and dashes, they're annoying when typing code
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

############################################################################
# Screen                                                                   #
############################################################################

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Save screenshots to ~/Desktop
defaults write com.apple.screencapture location -string "${HOME}/Desktop"
defaults write com.apple.screencapture type -string "png"

# Enable subpixel font rendering on non-Apple LCDs
defaults write NSGlobalDomain AppleFontSmoothing -int 2

# General: enable HiDPI display modes (requires restart)
sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true

############################################################################
# Finder                                                                   #
############################################################################

# Finder: allow quitting via ⌘ + Q; doing so will also hide desktop icons
defaults write com.apple.finder QuitMenuItem -bool true

# Finder: disable window and Get Info animations
defaults write com.apple.finder DisableAllAnimations -bool false

# General: Enable icons for hard drives, servers, and removable media on the desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowMountedServersOnDesktop -bool false
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Finder: show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool false

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool false

# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool false

# Finder: allow text selection in Quick Look
defaults write com.apple.finder QLEnableTextSelection -bool true

# Finder: display full path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool false

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# General: enable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Finder: enable spring loading for directories
defaults write NSGlobalDomain com.apple.springing.enabled -bool true

# Remove the spring loading delay for directories
defaults write NSGlobalDomain com.apple.springing.delay -float 0

# General: create .DS_Store files on network volumes and usb drives
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Finder: automatically open a new window when a volume is mounted
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

# General: enable the warning before emptying the Trash
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# Show the ~/Library folder
chflags nohidden ~/Library

# Expand the following File Info panes:
# “General”, “Open with”, and “Sharing & Permissions”
defaults write com.apple.finder FXInfoPanesExpanded -dict \
    General -bool true \
    OpenWith -bool true \
    Privileges -bool true

############################################################################
# Dock, Dashboard, and hot corners                                         #
############################################################################

# Set the icon size of Dock items to 48 pixels
defaults write com.apple.dock tilesize -int 48

# Dock: enable magnification
defaults write com.apple.dock magnification -bool false

# Set magnification icon size to 80 pixels
defaults write com.apple.dock largesize -float 80

# Dock: minimize windows into their application's icon
defaults write com.apple.dock minimize-to-application -bool false

# Dock: enable spring loading for all Dock items
defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true

# Dock: enable animation when opening applications
defaults write com.apple.dock launchanim -bool true

# Speed up Mission Control animations
defaults write com.apple.dock expose-animation-duration -float 0.1

# Don’t group windows by application in Mission Control
# (i.e. use the old Exposé behavior instead)
defaults write com.apple.dock expose-group-by-app -bool false

# General: enable Dashboard as a space
defaults write com.apple.dock dashboard-in-overlay -bool false

# General: automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

# Remove the auto-hiding Dock delay
defaults write com.apple.dock autohide-delay -float 0.1

# Speed up animation when hiding/showing the Dock
defaults write com.apple.dock autohide-time-modifier -float 0.3

# Dock: automatically hide and show
defaults write com.apple.dock autohide -bool true

# Dock: make icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool true

# Reset Launchpad
find ~/Library/Application\ Support/Dock -name "*.db" -maxdepth 1 -delete

# Hot corners
# Possible values:
#  0: no-op
#  2: Mission Control
#  3: Show application windows
#  4: Desktop
#  5: Start screen saver
#  6: Disable screen saver
#  7: Dashboard
# 10: Put display to sleep
# 11: Launchpad
# 12: Notification Center
# Top left screen corner → Dashboard
defaults write com.apple.dock wvous-tl-corner -int 0
defaults write com.apple.dock wvous-tl-modifier -int 0
# Top right screen corner → Desktop
defaults write com.apple.dock wvous-tr-corner -int 12
defaults write com.apple.dock wvous-tr-modifier -int 0
# Bottom left screen corner → Mission Control
defaults write com.apple.dock wvous-bl-corner -int 0
defaults write com.apple.dock wvous-bl-modifier -int 0
# Bottom right screen corner → Launchpad
defaults write com.apple.dock wvous-br-corner -int 0
defaults write com.apple.dock wvous-br-modifier -int 0

############################################################################
# Terminal
############################################################################

# Only use UTF-8 in Terminal.app
defaults write com.apple.terminal StringEncodings -array 4

############################################################################
# Alfred
############################################################################

# Set up sync folder
defaults write com.runningwithcrayons.Alfred-Preferences-3 syncfolder -string "~/Library/Mobile Documents/com~apple~CloudDocs/Alfred"

############################################################################
# Magnet
############################################################################

# Set keyboard mappings for Magnet
defaults write com.crowdcafe.windowmagnet expandWindowEastComboKey -dict keyCode 124 modifierFlags 1572864
defaults write com.crowdcafe.windowmagnet expandWindowWestComboKey -dict keyCode 123 modifierFlags 1572864
defaults write com.crowdcafe.windowmagnet maximizeWindowComboKey -dict keyCode 126 modifierFlags 1572864
defaults write com.crowdcafe.windowmagnet restoreWindowComboKey -dict keyCode 125 modifierFlags 1572864

############################################################################
# Dash
############################################################################

# Set up syncing for Dash
defaults write com.kapeli.dashdoc.plist syncFolderPath -string "~/Library/Mobile Documents/com~apple~CloudDocs"
defaults write com.kapeli.dashdoc.plist shouldSyncBookmarks -bool true
defaults write com.kapeli.dashdoc.plist shouldSyncDocsets -bool true
defaults write com.kapeli.dashdoc.plist shouldSyncGeneral -bool true
defaults write com.kapeli.dashdoc.plist shouldSyncView -bool true

############################################################################
# Kill affected applications                                               #
############################################################################

for app in "Dock" "Finder" "SystemUIServer" "iCal" "Alfred" "Magnet" "Dash"; do
    killall "${app}" > /dev/null 2>&1
done
echo "Done. Note that some of these changes require a logout/restart to take effect."
