# 🛠️ macOS Neovim Setup Guide (v0.11)

Everything you need from Git + SSH to fonts, plugins, and language servers—in one place.

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Git & SSH Configuration](#git--ssh-configuration)
3. [Install Neovim](#install-neovim)
4. [Clone Your Neovim Config](#clone-your-neovim-config)
5. [Install Nerd Font & Set Terminal Font](#install-nerdfont--set-terminal-font)
6. [Required & Recommended CLI Tools](#required--recommended-cli-tools)
7. [Launch Neovim & Install Plugins](#launch-neovim--install-plugins)
8. [LSP / Formatter Setup with Mason](#lsp--formatter-setup-with-mason)
9. [Quality‑of‑Life Tweaks](#quality-of-life-tweaks)
10. [Troubleshooting / FAQ](#troubleshooting--faq)

---

## Prerequisites

### Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

---

## Git & SSH Configuration

1. **Install Git**

   ```bash
   brew install git
   ```

2. **Set global identity**

   ```bash
   git config --global user.name  "Your Name"
   git config --global user.email "you@example.com"
   ```

3. **Generate an SSH key**

   ```bash
   ssh-keygen -t ed25519 -C "you@example.com"
   # Press <Enter> through the prompts (or set a passphrase if you like)
   ```

4. **Add key to agent & create config**

   ```bash
   eval "$(ssh-agent -s)"
   mkdir -p ~/.ssh
   cat >> ~/.ssh/config <<'EOF'
   Host github.com
     AddKeysToAgent yes
     IdentityFile ~/.ssh/id_ed25519
   EOF
   ssh-add ~/.ssh/id_ed25519
   ```

5. **Add the public key to GitHub**

   ```bash
   pbcopy < ~/.ssh/id_ed25519.pub  # copies key to clipboard
   ```

   > GitHub ▸ **Settings ▸ SSH and GPG keys ▸ New SSH key** ▸ paste ▸ **Add key**.

6. **Test**

   ```bash
   ssh -T git@github.com
   # Expect: “Hi <username>! You've successfully authenticated …”
   ```

---

## Install Neovim

```bash
brew install neovim
nvim --version  # should show v0.11.x
```

---

## Clone Your Neovim Config

```bash
# Remove any previous config
rm -rf ~/.config/nvim

# Clone your repo (replace with your own)
git clone git@github.com:desmond-45/nvim-config.git ~/.config/nvim
```

---

## Install Nerd Font & Set Terminal Font

1. **Install a patched font (avoid the *Mono* variant for bigger icons):**

   ```bash
   brew tap homebrew/cask-fonts
   brew install --cask font-jetbrains-mono-nerd-font
   ```

2. **Set the font in your terminal:**

| Terminal           | Steps                                                                                                                                         |
| ------------------ | --------------------------------------------------------------------------------------------------------------------------------------------- |
| **iTerm2**         | Preferences ▸ Profiles ▸ *Text* ▸ **Font** ▸ choose `JetBrainsMono Nerd Font`                                                                 |
| **Apple Terminal** | Settings ▸ Profiles ▸ *Text* ▸ **Change Font** ▸ choose `JetBrainsMono Nerd Font`                                                             |
| **Alacritty**      | `~/.config/alacritty/alacritty.yml`:<br/>`yaml<br/>font:<br/>  normal:<br/>    family: "JetBrainsMono Nerd Font"<br/>    style: Regular<br/>` |

Restart the terminal after changing the font.

---

## Required & Recommended CLI Tools

| Purpose                      | Command                                                                       |
| ---------------------------- | ----------------------------------------------------------------------------- |
| **Icons**                    | (Already installed Nerd Font above)                                           |
| **Fuzzy search (Telescope)** | `brew install ripgrep fd`                                                     |
| **LSP toolchains**           | <ul><li>Go   → `brew install go`</li><li>Node → `brew install node`</li></ul> |
| **Git TUI (optional)**       | `brew install lazygit`                                                        |

---

## Launch Neovim & Install Plugins

```bash
nvim
```

On first open, your plugin manager (Lazy.nvim / Packer / NvChad) will sync and install plugins automatically.

---

## LSP / Formatter Setup with Mason

Inside Neovim:

```vim
:Mason
```

Use the UI to install, for example:

* `gopls`
* `pyright`
* `typescript-language-server`
* `prettier`
* `html-lsp`, `css-lsp`, etc.

---

## Quality‑of‑Life Tweaks

| What                     | Command                                                                                                 |
| ------------------------ | ------------------------------------------------------------------------------------------------------- |
| **Alias `vim` → `nvim`** | `echo 'alias vim="nvim"' >> ~/.zshrc && source ~/.zshrc`                                                |
| **Caps Lock → Esc**      | System Settings ▸ Keyboard ▸ *Keyboard Shortcuts* ▸ **Modifier Keys…** ▸ set **Caps Lock** → **Escape** |

---

## Troubleshooting / FAQ

| Problem                                      | Fix                                                                                                           |
| -------------------------------------------- | ------------------------------------------------------------------------------------------------------------- |
| `??` icons or boxes                          | Ensure terminal font is set exactly to *JetBrainsMono Nerd Font* (not **Mono** variant) and restart terminal. |
| `Permission denied (publickey)` when cloning | `ssh-add ~/.ssh/id_ed25519`, ensure key is added in GitHub Settings.                                          |
| Mason installs failing for `go`/`npm`        | Install `go` and `node` via Homebrew (see above).                                                             |
| Telescope search errors                      | Verify `ripgrep` (`rg`) and `fd` are in PATH.                                                                 |

---

### 🎉 You’re all set. Enjoy Neovim with pretty icons, fuzzy finding, and full LSP power!
