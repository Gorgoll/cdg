# cdg

A terminal directory navigator. Browse your filesystem interactively and `cd` into any folder without typing paths.

# Preview

<img src="https://files.catbox.moe/ij5o0i.gif"/>

## Installation

```bash
curl -sSL https://raw.githubusercontent.com/Gorgoll/cdg/main/install.sh | bash
source ~/.bashrc
```

This will:
- Download the `cdg` binary to `~/.local/bin/`
- Add the `cdg` shell function to your `~/.bashrc` or `~/.zshrc`

---

## Usage

Just run:

```
cdg
```

- Use arrow keys to navigate
- Select a folder to enter it
- Choose `__UP__` to go to the parent directory
- Choose `__Exit__` to `cd` into the current directory and quit

---

## Notice

- Tested on Linux only macOS builds are available in the releases but untested

## Manual Installation

download the binary for your platform from the [releases page](https://github.com/Gorgoll/cdg/releases/latest) and add the following function to your shell config:

```bash
cdg(){
    local dir
    dir=$(~/.local/bin/cdg-bin 2>/dev/tty)
    [ -n "$dir" ] && cd "$dir"
}
```
