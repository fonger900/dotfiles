# 🚀 Fullstack Development Workflow

This guide walks through the recommended workflow for building fullstack applications using this environment. It focuses on the "inner loop" of development—how to move quickly from an idea to a running application.

---

## 🛠️ Phase 1: Scaffolding

Start by using the built-in project initialization aliases. These are configured in `zsh/aliases.zsh` to provide sensible defaults for modern stacks.

### Choose Your Stack
- **Next.js (TS/Tailwind)**: `cnext my-app`
- **Vite (React/Vue)**: `cvite my-app`
- **T3 Stack**: `ct3 my-app`
- **Django**: `djstart my-project`
- **FastAPI**: `fapistart my-api`

---

## 🏗️ Phase 2: Setting the Stage (Tmux)

Once your project is created, initialize your workspace. **Never work in a raw terminal; always use Tmux.**

1.  **Start a session**: `tmux new -s my-project`
2.  **Apply Fullstack Layout**: Press `Prefix + Alt+F`.
    - **Left Pane**: Your main editor (`nvim .`).
    - **Top-Right**: Your frontend or API dev server.
    - **Bottom-Right**: A utility pane for Git, logs, or temporary commands.

---

## 🐳 Phase 3: Services & Databases

Most fullstack apps require a database or cache. Use the **Tmux Popups** to manage these without losing your place in the code.

1.  **Start Services**: Use `dcud` (`docker-compose up -d`) to start your database in the background.
2.  **Monitor in Popups**:
    - `Prefix + Ctrl+D`: Check Docker status and resource usage.
    - `Prefix + G`: Open a quick terminal to run a database migration or seed command.
3.  **Local Development**: If you don't need full Docker, use `container` (`cs start`) for lightweight macOS-native containers.

---

## ⚡ Phase 4: The Inner-Loop (Neovim)

This is where you spend 90% of your time. Mastery of the keymaps is essential.

### Navigation
- **Files**: `<leader>ff` to jump between components.
- **Code**: `gd` (Go to Definition) to explore library code or internal modules.
- **Buffers**: `<S-l>` and `<S-h>` to cycle through open files.

### Coding
- **LSP Actions**: When you see a diagnostic error, hit `<leader>ca` (Code Action) for a quick fix or auto-import.
- **Formatting**: Just save the file (`:w`). **Conform.nvim** handles Prettier, Ruff, or GoFmt automatically.

### Integrated Terminals
- Use `<C-/>` (Snacks) for **ephemeral commands**: `npm install <package>`, `ls`, or `cat .env`.
- Use `<leader>tt` (ToggleTerm) for **persistent commands**: Running a test suite in watch mode.

---

## 🧪 Phase 5: Testing & Debugging

### API Testing
- Use the `Prefix + G` popup to run `curl` or `httpie` commands against your local API.
- Monitor your API logs in the **bottom-right** Tmux pane.

### Troubleshooting
- **Logs**: If something crashes, jump to the server pane (`Alt+K` or `Alt+L`) and scroll through the output.
- **Diagnostic List**: Use `<leader>xx` (Trouble) to see a project-wide list of errors and warnings.

---

## 🚢 Phase 6: Version Control (Git)

1.  **Check Status**: `Prefix + Shift+G` (Popup) for a quick `git status`.
2.  **Deep Work**: `<leader>gg` inside Neovim to open **LazyGit**. This is the most efficient way to stage hunks, resolve conflicts, and manage branches.
3.  **Quick Push**: `qpush "feat: add user authentication"` to stage, commit, and push in one go.

---

## 💤 Phase 7: Persistence

The best part of this workflow: **You never have to close your work.**

1.  **Detach**: `Prefix + D`. Your servers keep running, your buffers stay open.
2.  **Resume**: `tmux attach -t my-project`. Everything is exactly where you left it.
3.  **Reboot**: If your machine restarts, Tmux-Continuum will attempt to restore your session automatically.

---

**Next Steps**:
- See the **[Cheat Sheet](./QUICK_REFERENCE.md)** for a list of all aliases mentioned here.
- Explore **[Languages Guide](./LANGUAGES_GUIDE.md)** for specific runtime configurations.
