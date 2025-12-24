#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ZSHRC="$HOME/.zshrc"
BIN_DIR="$HOME/bin"
MARK_BEGIN="# >>> OSCP-SESSKIT >>>"
MARK_END="# <<< OSCP-SESSKIT <<<"

BLOCK_CONTENT=$(cat <<'EOF'
# >>> OSCP-SESSKIT >>>
export PATH="$HOME/bin:$PATH"

target() {
  if [ -z "$1" ]; then
    echo "Usage: t <IP>"
    return 1
  fi
  export IP="$1"
  export ip="$1"
  echo -e "\e[1;31m[+] Target set to:\e[0m $IP"
  tmux setenv -g IP "$IP" 2>/dev/null || true
}
alias t='target'

sls () { sess list }
scd () { eval "$(sess cd "$1")" }

listen () {
  local p="${1:-4444}"
  rlwrap -cAr nc -lvnp "$p"
}

s () {
  export SUSER="$1"
  export SVEC="$2"
  eval "$(sess new)"
}
ph () { export SPHASE="$1"; echo "[*] PHASE=$SPHASE"; }
note () { export SNOTE="$*"; echo "[*] NOTE=$SNOTE"; }
# <<< OSCP-SESSKIT <<<
EOF
)

echo "[*] Installing sess to $BIN_DIR ..."
mkdir -p "$BIN_DIR"
install -m 0755 "$REPO_DIR/bin/sess" "$BIN_DIR/sess"

echo "[*] Updating $ZSHRC (idempotent block) ..."
touch "$ZSHRC"

# Remove existing block if present
if grep -qF "$MARK_BEGIN" "$ZSHRC"; then
  # delete from begin to end (inclusive)
  awk -v b="$MARK_BEGIN" -v e="$MARK_END" '
    $0==b {inblk=1; next}
    $0==e {inblk=0; next}
    !inblk {print}
  ' "$ZSHRC" > "$ZSHRC.tmp"
  mv "$ZSHRC.tmp" "$ZSHRC"
fi

# Append fresh block at end
printf "\n%s\n" "$BLOCK_CONTENT" >> "$ZSHRC"

echo "[+] Done."
echo "    Run: source ~/.zshrc"
echo "    Test: t 1.1.1.1 ; s user vec ; sls ; listen"
