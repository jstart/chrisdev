build: update
install: git setup nvm mac mac-dock mac-apps

GIT_USER_NAME := $(shell git config --get --global user.name)
GIT_USER_EMAIL := $(shell git config --get --global user.email)

.PHONY: update
update:
	@echo 'Updating $(shell pwd)'
	@git pull origin master
	@git submodule update
	@git submodule foreach git pull origin master
	@echo 'Updating Vim'
	@vim +BundleUpdate +qall
	@echo 'Updating Gems'
	@gem update || true
	@echo 'Updating Homebrew'
	@type brew >/dev/null 2>&1 && brew update && brew upgrade --all || true

.PHONY: git
git:
	@echo 'Configuring git'
	@git config --global color.ui true
	@read -r -p "Name ($(GIT_USER_NAME)): " NAME; \
	 if [ ! -z "$$NAME" ]; then \
	   git config --global user.name "$$NAME"; \
	 fi
	@read -r -p "Email ($(GIT_USER_EMAIL)): " EMAIL; \
	 if [ ! -z "$$EMAIL" ]; then \
	   git config --global user.email "$$EMAIL"; \
	 fi

.PHONY: setup
setup:
	@echo 'Installing'
	git submodule update --init
	## Install dotfiles
	rm -rf $(HOME)/.vim
	ln -s  $(PWD)/vim          $(HOME)/.vim
	rm -f  $(HOME)/.vimrc
	ln -s  $(PWD)/vim/.vimrc   $(HOME)/.vimrc
	rm -rf $(HOME)/.oh-my-zsh
	ln -s  $(PWD)/oh-my-zsh    $(HOME)/.oh-my-zsh
	rm -f  $(HOME)/.zshrc
	ln -s  $(PWD)/shell/.zshrc $(HOME)/.zshrc
	rm -f  $(HOME)/.tmux.conf
	ln -s  $(PWD)/tmux/.tmux.conf $(HOME)/.tmux.conf
	rm -f  $(HOME)/.slate
	ln -s  $(PWD)/slate/.slate $(HOME)/.slate
	## Install Vim plugins
	vim +BundleInstall +qall
	## Change shell
	echo 'Changing shell. Enter your password if prompted.'
	chsh -s /bin/zsh

.PHONY: nvm
nvm:
	@echo 'Installing NVM'
	curl https://raw.github.com/creationix/nvm/master/install.sh | sh

.PHONY: mac
mac:
ifeq ($(shell uname),Darwin)
	@echo 'Configuring Mac preferences'
	osascript applescript/*.applescript
	@echo 'Installing other Homebrew packages'
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	brew tap homebrew/dupes || true
	brew tap josegonzalez/homebrew-php || true
	brew install vim --override-system-vi
	brew install \
		composer \
		git \
		mosh \
		nvm \
		optipng \
		rbenv \
		ruby-build \
		tmux \
		wget \
		youtube-dl \
		zsh \
		zsh-syntax-highlighting
	brew install caskroom/cask/brew-cask
	@echo 'Mac Defaults'
	# Text Replacement in all apps
	defaults write -g WebAutomaticTextReplacementEnabled -bool true
	# Expand save panel by default
	defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
	# Save to disk (not to iCloud) by default
	defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false
	# Copy email addresses as `foo@example.com` instead of `Foo Bar <foo@example.com>` in Mail.app
	defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false
	# Totally disable the dashboard
	defaults write com.apple.dashboard mcx-disabled -boolean TRUE
	# Always open everything in Finder's list view. This is important.
	defaults write com.apple.Finder FXPreferredViewStyle Nlsv
	# Show the ~/Library folder.
	chflags nohidden ~/Library
	# Disable the warning when changing a file extension
	defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
	# Finder: show all filename extensions
	defaults write NSGlobalDomain AppleShowAllExtensions -bool true
	# Add iOS Simulator to Launchpad
	[ ! -L /Applications/iOS\ Simulator.app ] && ln -s /Applications/Xcode.app/Contents/Applications/iPhone\ Simulator.app /Applications/iOS\ Simulator.app || true
	# Finder: show status bar
	defaults write com.apple.finder ShowStatusBar -bool true
	# Disable the “Are you sure you want to open this application?” dialog
	defaults write com.apple.LaunchServices LSQuarantine -bool false
	defaults write com.apple.dt.Xcode ShowBuildOperationDuration YES
	defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool YES

	launchctl unload -w /System/Library/LaunchAgents/com.apple.rcd.plist

endif

.PHONY: mac-dock
mac-dock:
ifeq ($(shell uname),Darwin)
	@echo 'Cleaning up dock'
	./dockutil/scripts/dockutil --remove "Contacts"
	./dockutil/scripts/dockutil --remove "Safari"
	./dockutil/scripts/dockutil --remove "Notes"
	./dockutil/scripts/dockutil --remove "Maps"
	./dockutil/scripts/dockutil --remove "FaceTime"
	./dockutil/scripts/dockutil --remove "Photo Booth"
	./dockutil/scripts/dockutil --remove "iBooks"
	./dockutil/scripts/dockutil --remove "App Store"
	./dockutil/scripts/dockutil --remove "System Preferences"
	./dockutil/scripts/dockutil --remove "Messages"
	./dockutil/scripts/dockutil --remove "iPhoto"
	./dockutil/scripts/dockutil --remove "Pages"
	./dockutil/scripts/dockutil --remove "Numbers"
	./dockutil/scripts/dockutil --remove "Keynote"
endif

.PHONY: mac-apps
mac-apps:
ifeq ($(shell uname),Darwin)
	brew cask install caffeine
	brew cask install google-chrome
	brew cask install iterm2
	brew cask install slate
	brew cask install spotifree
	brew cask install spotify
	brew cask install flux
	brew cask install transmission
	brew cask install vlc
	brew cask install qlmarkdown
	brew cask install qlstephen
endif

.PHONY: ssh-key
ssh-key:
	@read -r -p "Email Address/Comment: " COMMENT; \
	 ssh-keygen -t rsa -C "$$COMMENT"
