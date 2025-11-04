#!/bin/bash
# Optional shell wrapper for pnpm-version-util
# This enables 'pnpm run version' as an alias to 'pnpm-version'
# Note: This is completely optional - you can just use 'pnpm-version' directly

cat << 'FUNCTION_EOF'

# ============================================
# PNPM wrapper for pnpm-version command
# ============================================
# This wrapper intercepts 'pnpm run version' and redirects to 'pnpm-version'
# All other pnpm commands work normally

pnpm() {
  # Intercept 'pnpm run version' specifically
  if [[ "$1" == "run" && "$2" == "version" && "$#" -eq 2 ]]; then
    command pnpm-version
  else
    # All other pnpm commands pass through normally
    command pnpm "$@"
  fi
}

FUNCTION_EOF

echo ""
echo "============================================"
echo "Installation Instructions:"
echo "============================================"
echo "Copy the function above to your ~/.zshrc or ~/.bashrc, then run:"
echo "  source ~/.zshrc  # or source ~/.bashrc"
echo ""
echo "After that, you can use 'pnpm run version' as a shortcut!"
echo ""
echo "Quick install:"
echo "  bash setup-shell.sh >> ~/.zshrc && source ~/.zshrc"
echo ""
echo "Note: You can also just use 'pnpm-version' directly without this wrapper."
echo "============================================"
