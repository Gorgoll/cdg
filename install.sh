#!/bin/bash

mkdir -p ~/.local/bin
curl -L https://github.com/Gorgoll/cdg/releases/latest/download/cdg-linux-x64 -o ~/.local/bin/cdg-bin
chmod +x ~/.local/bin/cdg-bin

FUNC='
cdg(){
    local dir
    dir=$(~/.local/bin/cdg-bin 2>/dev/tty)
    [ -n "$dir" ] && cd "$dir"
}'

if [ -n "$ZSH_VERSION" ] || [ "$SHELL" = "/bin/zsh" ]; then
    echo "$FUNC" >> ~/.zshrc
    echo "Added cdg to ~/.zshrc — run: source ~/.zshrc"
else
    echo "$FUNC" >> ~/.bashrc
    echo "Added cdg to ~/.bashrc — run: source ~/.bashrc"
fi