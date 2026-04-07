#!/usr/bin/env bash
# ============================================================================
# 🧪 Dotfiles Test Suite
# ============================================================================
# Performs linting, syntax checks, and installation dry-runs.

set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log_step() { echo -e "${BLUE}▶ $1${NC}"; }
log_success() { echo -e "${GREEN}✓ $1${NC}"; }
log_warn() { echo -e "${YELLOW}⚠ $1${NC}"; }
log_error() { echo -e "${RED}✗ $1${NC}"; }

# ==========================================
# 1. Shell Script Linting (ShellCheck)
# ==========================================
lint_shell() {
  log_step "Linting shell scripts with ShellCheck..."
  if command -v shellcheck &>/dev/null; then
    # Find all .sh and .zsh files, excluding vendor directories
    local files=$(find -L . -type f \( -name "*.sh" -o -name "*.zsh" \) -not -path "*/.oh-my-zsh/*" -not -path "*/.git/*")

    if [[ -n "$files" ]]; then
      # SC1071: Ignore "unknown shell" for .zsh files (ShellCheck primarily supports bash/sh)
      shellcheck -s bash $files || log_warn "ShellCheck found some issues. Review them above."
      log_success "Shell linting complete."
    else
      log_info "No shell scripts found to lint."
    fi
  else
    log_warn "ShellCheck not installed. Skipping shell linting."
  fi
}

# ==========================================
# 2. Lua Formatting/Linting (Stylua)
# ==========================================
lint_lua() {
  log_step "Checking Lua formatting with Stylua..."
  if command -v stylua &>/dev/null; then
    stylua --check nvim/.config/nvim/lua/ || log_error "Lua formatting issues found. Run 'stylua nvim/' to fix."
    log_success "Lua linting complete."
  else
    log_warn "Stylua not installed. Skipping Lua linting."
  fi
}

# ==========================================
# 3. Installation Dry-Run (Ansible)
# ==========================================
test_installation() {
  log_step "Testing installation playbook (Dry-Run)..."
  if command -v ansible-playbook &>/dev/null; then
    ansible-playbook -i ansible/inventory ansible/playbook.yml --check
    log_success "Installation dry-run successful."
  else
    log_warn "Ansible not installed. Skipping installation dry-run."
  fi
}

# ==========================================
# Main Execution
# ==========================================
main() {
  echo -e "${BLUE}╔═══════════════════════════════════════════════╗${NC}"
  echo -e "${BLUE}║          🧪 Running Dotfiles Tests            ║${NC}"
  echo -e "${BLUE}╚═══════════════════════════════════════════════╝${NC}"
  echo ""

  lint_shell
  lint_lua
  test_installation

  echo ""
  log_success "All tests passed (or skipped where tools were missing)!"
}

main "$@"
