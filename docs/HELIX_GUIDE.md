# Helix Editor Guide (Fullstack Dev)

This guide covers the Helix configuration provided in this dotfiles repo, tailored for fullstack development (TS, Python, Go, Rust, etc.).

## ⚡ Quick Start

| Command | Action |
| :--- | :--- |
| `hx .` | Open current directory |
| `hx filename` | Open specific file |
| `hx +15 filename` | Open file at line 15 |

## 🔑 Key Concepts (Vs Vim)

**Selection → Action** (The Helix Way)
*   **Vim:** `d` (action) -> `w` (object) = "delete word"
*   **Helix:** `w` (object/selection) -> `d` (action) = "select word, then delete"

This allows you to see exactly what you are acting on *before* you act.

## 🗺️ Navigation

| Key | Action |
| :--- | :--- |
| `h` `j` `k` `l` | Move cursor (left, down, up, right) |
| `w` / `b` | Move forward/backward by word |
| `e` | Move to end of word |
| `ge` | Move to end of previous word |
| `f{char}` | Move to next occurrence of char |
| `t{char}` | Move to right before next char |
| `G` | Go to end of file |
| `gg` | Go to start of file |
| `Ctrl+u` / `Ctrl+d` | Scroll up/down half page |

## 📝 Editing (Normal Mode)

| Key | Action |
| :--- | :--- |
| `i` | Insert before cursor |
| `a` | Insert after cursor |
| `I` | Insert at start of line |
| `A` | Insert at end of line |
| `o` | Open new line below |
| `O` | Open new line above |
| `u` | Undo |
| `U` | Redo |
| `y` | Yank (copy) selection |
| `p` | Paste after cursor |
| `P` | Paste before cursor |
| `r` | Replace character |
| `R` | Replace selection |
| `d` | Delete selection |
| `c` | Change selection (delete + insert) |

## 🔧 Selection Manipulation

| Key | Action |
| :--- | :--- |
| `v` | Enter selection mode (extend selection) |
| `x` | Select current line |
| `;` | Collapse selection to cursor |
| `Alt+;` | Flip selection cursor |
| `%` | Select entire file |
| `s` | Select regex within selection |
| `S` | Split selection on regex |
| `C` | Copy selection to next line (multiple cursors) |
| `Alt+s` | Split selection into lines |

## 🚀 Leader Keys (Space)

Our config maps `Space` as the leader key.

| Key | Action |
| :--- | :--- |
| `Space f` | **File Picker** (Fuzzy find files) |
| `Space b` | **Buffer Picker** (Switch open files) |
| `Space w` | Save file |
| `Space q` | Quit |
| `Space /` | Global search in project |
| `Space s` | Symbol picker |
| `Space a` | Code actions |
| `Space r` | Rename symbol |
| `Space d` | Diagnostics picker |

## 🧠 LSP & Coding

Fullstack languages (TS/JS, Python, Go, Rust) are pre-configured.

| Key | Action |
| :--- | :--- |
| `gd` | Go to definition |
| `gr` | Go to references |
| `gy` | Go to type definition |
| `K` | Hover documentation |
| `Space r` | Rename symbol |
| `Space a` | Code actions (fixes, imports) |
| `[d` / `]d` | Previous/Next diagnostic |
| `Space d` | Show all diagnostics |
| `Space s` | Document symbols (outline) |
| `Space S` | Workspace symbols |

## 🖥️ Window Management

| Key | Action |
| :--- | :--- |
| `Ctrl+w v` | Split vertically |
| `Ctrl+w s` | Split horizontally |
| `Ctrl+w h/j/k/l` | Switch window |
| `Ctrl+w c` | Close window |
| `Ctrl+w o` | Close other windows |

## 🛠️ Configuration

Your config is located at: `~/.config/helix/config.toml`

**Key Settings:**
*   Theme: `tokyonight`
*   Relative line numbers: `on`
*   Bufferline: `always`
*   Cursorline: `on`
*   Auto-format: `on` (for all languages)

**Key Mappings:**
*   `jk` (Insert Mode): Exit to Normal Mode
*   `Ctrl+s` (Normal): Save
*   `Ctrl+q` (Normal): Quit
*   `Ctrl+/`: Toggle comments
