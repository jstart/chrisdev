## Installation

### Requirements

#### OS-X

```
sudo xcodebuild -license
xcode-select --install
```

## Installation

```
git clone https://github.com/jstart/chrisdev.git ~/Development/dotfiles
cd ~/Development/dotfiles
make install
```

### Configuring iTerm2

1. Set iTerm2 preferences URL on the General tab to the location of the `iterm2` folder
2. Restart iTerm2

## Updating

```
$ make update
```

## Other

Generate a new SSH key

```
$ make ssh-key
```
