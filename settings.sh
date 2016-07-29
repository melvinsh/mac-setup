#!/bin/bash

echo "Enabling three-finger drag ..."
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true

echo "Enabling dark mode ..."
dark-mode --mode Dark

echo "Unhiding Library in Finder ..."
chflags nohidden ~/Library

echo "Disabling Desktop icons (AKA force clean Desktop) ..."
defaults write com.apple.finder CreateDesktop -bool false

echo "Setting Default Finder Location to Home Folder ..."
defaults write com.apple.finder NewWindowTarget -string "PfLo" && \
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}"

echo "Enabling iOS charging sound when MagSafe is connected ..."
defaults write com.apple.PowerChime ChimeOnAllHardware -bool true && \
open /System/Library/CoreServices/PowerChime.app

echo "Disabling autocorrect ..."
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false

echo "Disabling Sound Effects on Boot ..."
sudo nvram SystemAudioVolume=" "

echo "Enabling Firewall ..."
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on

echo "Setting screensaver to lock immediately ..."
defaults write com.apple.screensaver askForPasswordDelay -int 0

echo "Starting locate database building service ..."
sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.locate.plist

echo "Disabling AirDrop ..."
defaults write com.apple.NetworkBrowser DisableAirDrop -bool YES

echo "Done! Reloading Finder ..."
killall Finder
