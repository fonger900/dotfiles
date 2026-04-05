# Bug Report: Severe Zsh Prompt Latency in WSL

## Symptom
Users operating within Windows Subsystem for Linux (WSL) experience a noticeable (~0.5s) lag every time the `Enter` key is pressed or when opening a new terminal session. This heavily impacts typing fluidity.

## Root Cause
The core issue originates from WSL's interop layer bridging the Windows system environment variables. By default, WSL mounts the `C:` drive to `/mnt/c/` and automatically appends all Windows `PATH` executables to the Linux `$PATH`.

In a modern fullstack environment, various shell tools execute operations via the `precmd` hook (running right before the new prompt is rendered). Two culprits were extremely punishing:
1. **Mise Activation Hook**: `mise activate zsh` intercepts every prompt change to query runtime states (`mise hook-env`). Under-the-hood, it parses paths.
2. **Starship Prompt**: Evaluates contextual git statuses and tool versions by finding tools via the Zsh `$PATH`.

Whenever these Linux binaries traverse into `/mnt/c/` boundaries to search for missing modules/commands, the Windows filesystem overhead causes execution time to bottleneck abruptly (measurably adding 100-400ms per traversal).

## Resolution

Rather than disabling `appendWindowsPath` globally in `/etc/wsl.conf` (which breaks the convenience of directly running VS Code (`code`) or `clip.exe` from WSL), we applied two precise fixes within the dotfiles logic:

### 1. Zsh Dynamic Path Pruning (`zsh/path.zsh`)
We implemented logic to proactively scrub out `/mnt/c/*` components from the shell `path` specifically on initialization, keeping only critical operational endpoints.

```zsh
# zsh/path.zsh
if [[ -n "$WSL_DISTRO_NAME" ]]; then
  local new_path=()
  for p in "${path[@]}"; do
    if [[ "$p" != /mnt/c/* ]] || [[ "$p" == *System32* ]] || [[ "$p" == *"VS Code/bin"* ]] || [[ "$p" == *"VSCode"* ]] || [[ "$p" == *WezTerm* ]] || [[ "$p" == *chrome* ]]; then
      new_path+=("$p")
    fi
  done
  path=("${new_path[@]}")
fi
```
**Impact:** `mise` and `starship` searches terminate rapidly without crossing over to NTFS. Latency cut drastically.

### 2. Using Mise Shims (`zsh/.zshrc`)
We converted `mise` to use standalone command shims instead of dynamic environment analysis on the `precmd` hook. Shims intercept the binary directly down the `$PATH` rather than polling on prompt redraws.

```diff
- eval "$(~/.local/bin/mise activate zsh)"
+ eval "$(~/.local/bin/mise activate zsh --shims)"
```
**Impact:** Extinguishes the `_mise_hook_precmd` execution penalty completely, resulting in an instant (`0.040s`) redraw.

## Validation
To track regressions, `zprof` or `time starship prompt` can be used. When these optimizations are correctly applied, prompt hooks execute in under 50 mills.
