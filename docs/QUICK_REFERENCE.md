# 🚀 Fullstack Dev Cheat Sheet

## ⌨️ Tmux (Prefix: `Ctrl+A`)

| Category | Command | Action |
|----------|---------|--------|
| **Sessions**| `tmux new -s <name>` | Create session |
| | `Prefix + S` | Switch session |
| | `Prefix + D` | Detach |
| **Windows** | `Alt+1-9` | **Jump to window** (No prefix) |
| | `Ctrl+Shift+T` | New window |
| | `Prefix + ,` | Rename window |
| **Panes** | `Alt+H/J/K/L` | **Navigate** (No prefix) |
| | `Ctrl+Shift+E` | Split Vertical |
| | `Ctrl+Shift+O` | Split Horizontal |
| | `Prefix + Z` | Zoom toggle |
| **Popups** | `Prefix + G` | Terminal |
| | `Prefix + Shift+G`| Git Status |
| | `Prefix + Ctrl+G` | Lazygit |
| **Layouts** | `Prefix + Alt+F` | Fullstack |
| | `Prefix + Alt+D` | Docker |

---

## 📝 Neovim (Leader: `Space`)

| Category | Keymap | Action |
|----------|---------|--------|
| **Files** | `<leader>ff` | Find Files (FZF) |
| | `<leader>fg` | Live Grep |
| | `<leader>fr` | Recent Files |
| | `<leader>e` | Toggle Explorer |
| **LSP** | `gd` | Go to Definition |
| | `gr` | References |
| | `K` | Hover Doc |
| | `<leader>ca` | Code Action |
| | `<leader>cr` | Rename |
| **Git** | `<leader>gg` | Lazygit |
| | `<leader>gb` | Blame line |
| **Term** | `<C-/>` | Quick (Snacks) |
| | `<leader>tt` | Toggle (ToggleTerm) |

---

## 📖 Document Viewer (Zathura)

| Keymap | Action |
|--------|--------|
| `r`    | Toggle Recolor (Dark Mode) |
| `i`    | Toggle Index (Table of Contents) |
| `f`    | Follow Links |
| `C-i`  | Zoom In |
| `C-o`  | Zoom Out |
| `/`    | Search |

---

## 🐚 Shell Aliases

| Tool | Alias | Action |
|------|-------|--------|
| **General** | `reload` | Source .zshrc |
| | `ll` | `eza -lh --icons` |
| | `lt` | `eza --tree` |
| **Git** | `gs` | `git status` |
| | `gp` | `git push` |
| | `gco` | `git checkout` |
| **Docker** | `dcu` | `docker-compose up` |
| | `dps` | `docker ps -a` |
| **Native** | `cl` | `container ls` |
| | `cr` | `container run` |
| **Node** | `ni` | `npm install` |
| | `nrd` | `npm run dev` |

---

## 🔍 Fuzzy Finding

- `Ctrl+R`: Search command history
- `Ctrl+T`: Search files in current dir
- `Alt+C`: Search and jump to subdirectories
- `z <name>`: Jump to a frequent directory (zoxide)

---

## 🛠️ Diagnostics

- `devsetup`: Check if all tools are installed
- `ports`: List all listening ports
- `killport <port>`: Kill process on specific port
