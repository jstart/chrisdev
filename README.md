## Installation

### Requirements

#### OS-X

```
sudo xcodebuild -license
xcode-select --install
```

## Installation

```
git clone https://github.com/jstart/chrisdev.git ~/Developer/dotfiles
cd ~/Developer/dotfiles
make install
```

## ZSH
At uber, i was told to switch to prezto https://github.com/sorin-ionescu/prezto 
Then edit ~/.zpreztorc: search for this line zstyle ':prezto:module:prompt' and update the theme part to be  powelevel10k. Restart your terminal and follow the wizard. (edited) 

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
