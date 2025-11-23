# 🖥️ Terminal Management Guide

Complete guide to using terminals in Neovim for development workflows.

## Terminal Systems

Your Neovim setup includes two complementary terminal systems:

1. **Snacks Terminal** (`<C-/>`): Quick, floating terminal for one-off commands
2. **ToggleTerm**: Persistent numbered terminals for long-running processes

## Quick Reference

| Action | Keymap | Description |
|--------|--------|-------------|
| Quick terminal | `<C-/>` | Snacks floating terminal for one-off commands |
| Main terminal | `<leader>tt` | Toggle ToggleTerm floating terminal |
| Float terminal | `<leader>tf` | Toggle ToggleTerm floating terminal |
| Terminal #1 | `:ToggleTerm 1` | First numbered terminal (dev server) |
| Terminal #2 | `:ToggleTerm 2` | Second numbered terminal (backend/git) |
| Terminal #3 | `:ToggleTerm 3` | Third numbered terminal (tests) |
| Exit terminal mode | `<Esc><Esc>` | Return to normal mode |
| Navigate windows | `<C-h/j/k/l>` | Move between windows (including terminals) |

## Basic Usage

### Snacks Terminal (Quick Commands)

Fastest way to run a quick command:

```lua
<C-/>           -- Toggle Snacks terminal (appears as floating window)
<Esc><Esc>      -- Exit terminal mode back to normal mode
```

**Best for**: Quick git commands, file operations, or short-lived tasks

### ToggleTerm (Persistent Terminals)

For long-running processes and development servers:

```lua
<leader>tt      -- Toggle main floating terminal
<leader>tf      -- Toggle floating terminal (same as above)

-- Access specific numbered terminals via command
:ToggleTerm 1   -- Development server
:ToggleTerm 2   -- Git operations  
:ToggleTerm 3   -- Testing/watching
:ToggleTerm 4   -- Database/Docker
```

**Best for**: Development servers, test watchers, database connections, build processes

### Terminal Layouts

ToggleTerm supports multiple layouts:

```vim
:ToggleTerm direction=float         " Floating window (default)
:ToggleTerm direction=horizontal    " Bottom split
:ToggleTerm direction=vertical      " Side split  
:ToggleTerm direction=tab           " New tab
```

## Navigation

### Window Navigation

Works from any window including terminals:

```lua
<C-h>           -- Move to left window
<C-j>           -- Move to window below
<C-k>           -- Move to window above
<C-l>           -- Move to right window
```

### Exit Terminal Mode

```lua
<Esc><Esc>      -- Exit terminal mode to normal mode
<C-\><C-n>      -- Alternative exit to normal mode
```

## Development Workflows

### Frontend Development

**Terminal 1** - Development Server (`:ToggleTerm 1`)

```bash
npm run dev
# or
yarn dev
# or
pnpm dev
```

**Terminal 2** - Git Operations (`:ToggleTerm 2`)

```bash
git status
git add .
git commit -m "feat: add new component"
git push
```

**Terminal 3** - Testing (`:ToggleTerm 3`)

```bash
npm test
# or
npm run test:watch
# or
vitest --watch
```

**Quick Commands** - Use Snacks Terminal (`<C-/>`)

```bash
npm install <package>
ls -la
cat package.json
```

### Fullstack Development

**Terminal 1** - Frontend Server (`:ToggleTerm 1`)

```bash
cd frontend
npm run dev          # React/Vue/Svelte/Angular
```

**Terminal 2** - Backend Server (`:ToggleTerm 2`)

```bash
cd backend
python manage.py runserver    # Django
# or
go run main.go                # Go
# or  
cargo run                     # Rust
# or
node server.js                # Node.js
```

**Terminal 3** - Database (`:ToggleTerm 3`)

```bash
docker-compose up postgres
# or
mysql -u root -p
# or
psql -U postgres
```

**Snacks Terminal** - Quick operations (`<C-/>`)

```bash
# Quick commands, file checks, etc.
docker ps
git status
npm audit fix
```

## Best Practices

### Recommended Terminal Organization

1. **Snacks Terminal (`<C-/>`)**: Quick, one-off commands
   - File operations (ls, cat, mkdir)
   - Quick git checks (git status, git diff)
   - Package installations
   - Short-lived tasks

2. **ToggleTerm #1**: Primary development server
   - Frontend: `npm run dev`, `yarn dev`
   - Backend: `python manage.py runserver`, `go run main.go`

3. **ToggleTerm #2**: Secondary service or git
   - Backend API (if fullstack)
   - Git operations for commits/pushes
   - Docker compose

4. **ToggleTerm #3**: Tests and monitoring
   - Test watchers: `npm test -- --watch`
   - Build watchers
   - Log monitoring

### Workflow Tips

1. **Use Snacks for Speed**: `<C-/>` is fastest for quick commands that don't need to stay open
2. **Number Your Terminals**: Mentally assign terminal numbers to specific tasks
3. **Floating for Logs**: Use floating terminals to monitor logs without losing screen space
4. **Horizontal for Side-by-Side**: Use `:ToggleTerm direction=vertical` when comparing output

## Example: Full Development Session

```bash
# 1. Quick check with Snacks Terminal
<C-/>
git status
npm --version
<Esc><Esc>

# 2. Start frontend dev server
:ToggleTerm 1
cd frontend && npm run dev
# Leave running, switch windows with <C-h/j/k/l>

# 3. Start backend server  
:ToggleTerm 2
cd backend && npm run dev
# Leave running

# 4. Run tests in watch mode
:ToggleTerm 3
npm test -- --watch
# Leave running

# 5. Quick operations with Snacks
<C-/>
npm install axios
git add .
git commit -m "feat: add API integration"
<Esc><Esc>

# All terminals persist - switch between them as needed
# Close terminals by toggling them off or closing Neovim
```

## Advanced Features

### Terminal Command Execution

Execute commands without opening a terminal:

```vim
:TermExec cmd="npm run build"        " Execute in default terminal
:TermExec cmd="git push" go_back=0   " Run and stay in terminal
```

### Terminal Persistence & State

- **ToggleTerm terminals persist**: Numbered terminals stay alive when hidden
- **Working directory preserved**: Each terminal remembers its current directory
- **Processes continue running**: Servers and watchers run in the background
- **Session restoration**: Terminal state persists across Neovim restarts (within same session)

---

**Pro Tip**: Master `<C-/>` for quick commands and numbered ToggleTerms for persistent processes to maximize your productivity! 🚀
