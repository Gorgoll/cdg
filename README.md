<p align="center">
  <img src="https://files.catbox.moe/6hg0st.png">
</p>

<p align="center">
  A terminal directory navigator. Browse your filesystem interactively and <code>cd</code> into any folder without typing paths.
</p>

---

## Preview

  <img src="https://files.catbox.moe/ij5o0i.gif"/>

---

## Installation

### Linux
```bash
curl -sSL https://raw.githubusercontent.com/Gorgoll/cdg/main/install.sh | bash
source ~/.bashrc
```

This will:
- Download the `cdg` binary to `~/.local/bin/`
- Add the `cdg` shell function to your `~/.bashrc` or `~/.zshrc`

### Windows
```powershell
irm https://raw.githubusercontent.com/Gorgoll/cdg/main/install.ps1 | iex
```

This will:
- Download the `cdg` binary to `$env:LOCALAPPDATA\cdg\cdg.exe`
- Add the `cdg` shell function to your PowerShell profile

### macOS

> ⚠️ macOS builds are available on the [releases page](https://github.com/Gorgoll/cdg/releases/latest) but are **untested**.

Download the binary manually and follow the [Manual Installation](#manual-installation) steps below.

---

## Usage

Just run:
```bash
cdg
```

| Key | Action |
|-----|--------|
| `↑` / `↓` | Navigate folders |
| `Enter` | Enter selected folder |
| `../` | Go to parent directory |
| `./` | `cd` into current directory and quit |

---

Cdg [options]

| Key   | Action |
|-------|--------|
| -h    | Help menu |
| -b name | Bookmark current directory |
| -b    | List all bookmarks |
| name  | Jump to a bookmarked directory |
---
## Manual Installation

1. Download the binary for your platform from the [releases page](https://github.com/Gorgoll/cdg/releases/latest).
2. Place it at `~/.local/bin/cdg-bin` (or anywhere on your `$PATH`).
3. Add the following function to your shell config:

**bash/zsh** (`~/.bashrc` or `~/.zshrc`):
```bash
cdg(){
    local dir
    dir=$(~/.local/bin/cdg-bin "$@" 2>/dev/tty)
    [ -n "$dir" ] && cd "$dir"
}
```

**PowerShell** (your PowerShell profile):
```powershell
function cdg {
    $dir = & "$env:LOCALAPPDATA\cdg\cdg.exe" @Args

    if ($dir -is [array]) {
        $dir = $dir[0]
    }
    if($dir){
        $dir = $dir.Trim()
        if (Test-Path $dir) {
            Set-Location $dir
        }
    }
}
```

4. Reload your shell:
```bash
# bash/zsh
source ~/.bashrc

# PowerShell
. $PROFILE
```

---

## Platform Support

| Platform | Status |
|----------|--------|
| Linux    | ✅ Tested   |
| Windows  | ✅ Tested   |
| macOS    | ⚠️ Untested |