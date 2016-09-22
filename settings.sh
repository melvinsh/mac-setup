#!/bin/bash

echo "Enabling three-finger drag ..."
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true

echo "Unhiding Library in Finder ..."
chflags nohidden ~/Library

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

echo "Changing screenshots directory to ~/Screenshots"
mkdir -p $HOME/Screenshots
defaults write com.apple.screencapture location $HOME/Screenshots
killall SystemUIServer

echo "Done! Reloading Finder ..."
killall Finder
