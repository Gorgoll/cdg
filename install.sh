#!/bin/bash
mkdir -p ~/.local/bin
arch=$(uname -m)
os=$(uname -s)

# OS
case "$os" in
    Linux) os="linux" ;;
    Darwin) os="macos" ;;
    *)
        echo "Unsupported OS: $os"
        exit 1
        ;;
esac

# CPU architecture
case "$arch" in
    x86_64) arch="x64" ;;
    aarch64|arm64) arch="arm64" ;;
    armv7l|armv6l) arch="arm" ;;
    *)
        echo "Unsupported architecture: $arch"
        exit 1
        ;;
esac

# Install the right version
file="cdg-$os-$arch"
curl -L "https://github.com/Gorgoll/cdg/releases/latest/download/$file" -o ~/.local/bin/cdg-bin
chmod +x ~/.local/bin/cdg-bin

# Functions

# Bash/Zsh
FUNC='cdg(){
    local dir
    dir=$(~/.local/bin/cdg-bin 2>/dev/tty)
    [ -n "$dir" ] && cd "$dir"
}'

# Fish
FISH_FUNC='function cdg
    set dir ( ~/.local/bin/cdg-bin 2>/dev/tty )
    if test -n "$dir"
        cd "$dir"
    end
end'

# Nushell
NU_FUNC='def cdg [] {
    let dir = (~/.local/bin/cdg-bin | str trim)
    if $dir != "" { cd $dir }
}'

# Elvish
ELV_FUNC='fn cdg {
    var dir = ( ~/.local/bin/cdg-bin )
    if (not-eq $dir "") { cd $dir }
}'

# Bash
if [ -f "$HOME/.bashrc" ]; then
    if ! grep -qs "cdg()" "$HOME/.bashrc"; then
        echo "$FUNC" >> "$HOME/.bashrc"
        echo "Added cdg to ~/.bashrc"
    else
        echo "cdg already exists in ~/.bashrc"
    fi
fi

# Zsh
if [ -f "$HOME/.zshrc" ]; then
    if ! grep -qs "cdg()" "$HOME/.zshrc"; then
        echo "$FUNC" >> "$HOME/.zshrc"
        echo "Added cdg to ~/.zshrc"
    else
        echo "cdg already exists in ~/.zshrc"
    fi
fi

# Fish
if [ -f "$HOME/.config/fish/config.fish" ]; then
    if ! grep -qs "function cdg" "$HOME/.config/fish/config.fish"; then
        echo "$FISH_FUNC" >> "$HOME/.config/fish/config.fish"
        echo "Added cdg to fish config"
    else
        echo "cdg already exists in fish config"
    fi
fi

# Nushell
if [ -f "$HOME/.config/nushell/config.nu" ]; then
    if ! grep -qs "def cdg" "$HOME/.config/nushell/config.nu"; then
        echo "$NU_FUNC" >> "$HOME/.config/nushell/config.nu"
        echo "Added cdg to nushell config"
    else
        echo "cdg already exists in nushell config"
    fi
fi

# Elvish
if [ -f "$HOME/.config/elvish/rc.elv" ]; then
    if ! grep -qs "fn cdg" "$HOME/.config/elvish/rc.elv"; then
        echo "$ELV_FUNC" >> "$HOME/.config/elvish/rc.elv"
        echo "Added cdg to elvish config"
    else
        echo "cdg already exists in elvish config"
    fi
fi
