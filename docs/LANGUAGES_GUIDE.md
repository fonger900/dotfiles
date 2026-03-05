# 🌍 Languages & Runtimes Guide

This guide covers the setup and management of various programming languages and their ecosystems within this environment.

## 🛠️ Version Management with Mise

We use **[mise](https://mise.jdx.dev/)** as the primary tool for managing language runtimes. It is faster than nvm, pyenv, or rbenv and handles multiple languages in a single tool.

### Common Mise Commands
```bash
mise ls-remote node    # List available Node.js versions
mise install node@22   # Install a specific version
mise use -g node@22    # Set global version
mise use node@20       # Set local project version (.mise.toml)
```

---

## 🟢 Node.js / JavaScript / TypeScript

### Package Managers
All major package managers are supported and aliased:
- **pnpm**: Recommended for its speed and disk efficiency.
- **bun**: Used for ultra-fast task running and modern JS runtime.
- **npm/yarn**: Standard fallbacks.

### Global Tools
Commonly used global tools installed via `pnpm`:
- `typescript`, `ts-node`
- `eslint`, `prettier`
- `vercel`, `netlify-cli`

---

## 🐍 Python

### Environment Management
While `mise` handles the Python runtime, use `venv` for project-specific dependencies:
```bash
# Using the venvnew alias
venvnew    # Creates and activates a .venv directory
```

### Essential Tools
- **Ruff**: An extremely fast Python linter and formatter (configured in Neovim).
- **Pyright**: Static type checker.
- **Poetry/uv**: Advanced dependency management.

---

## 🐹 Go

### Path Configuration
- **GOPATH**: Set to `~/go`.
- **GOBIN**: Added to system PATH.

### Workflow
```bash
go mod init <name>
go get <package>
go run .
```

---

## 🦀 Rust

### Installation
Rust is managed via `rustup` (installed via Homebrew or manually):
```bash
rustup update
cargo build
cargo run
```

---

## 🐳 Containers & DevOps

### Native macOS Containers (`container`)
A lightweight, native alternative to Docker Desktop.
- `cs start`: Start the engine.
- `cl`: List containers.
- `cr -it alpine`: Run an interactive shell.

### Docker (Legacy/Compatibility)
Used for complex multi-container orchestration.
- `dcu`: `docker-compose up`
- `dcud`: `docker-compose up -d`
- `dclf`: Follow logs.

---

## 🏗️ Fullstack Project Structure

Recommended project layout for seamless integration with our Tmux layouts:

```text
my-project/
├── frontend/          # React, Vue, or Next.js
├── backend/           # FastAPI, Go, or Node.js
├── docker-compose.yml
├── .env.example
└── README.md
```

**Pro Tip**: Use the **Fullstack Layout** (`Prefix + Alt+F`) when working in this structure to have your editor on the left and both servers/logs on the right.

---

**Next Steps**:
- See the **[Cheat Sheet](./QUICK_REFERENCE.md)** for all language-specific aliases.
- Configure your editor in the **[Neovim Guide](./NEOVIM_GUIDE.md)**.
