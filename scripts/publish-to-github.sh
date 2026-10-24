#!/usr/bin/env bash
# Run in macOS Terminal (not inside Cursor): connects GitHub and publishes this site.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

REPO_NAME="ghosts-of-chinatown-site"
CUSTOM_DOMAIN="ghost.daixcompose.com"

if ! command -v gh >/dev/null 2>&1; then
  echo "GitHub CLI (gh) is required. Install: https://cli.github.com or: brew install gh"
  exit 1
fi

if ! gh auth status >/dev/null 2>&1; then
  echo "Sign in to GitHub (browser will open)…"
  gh auth login --hostname github.com --git-protocol https --web
fi

USER="$(gh api user -q .login)"
echo "Signed in as: $USER"

if git remote get-url origin >/dev/null 2>&1; then
  echo "Remote origin already set."
else
  if gh repo view "$USER/$REPO_NAME" >/dev/null 2>&1; then
    echo "Repo exists; adding remote…"
    git remote add origin "https://github.com/$USER/$REPO_NAME.git"
  else
    echo "Creating public repo and pushing…"
    gh repo create "$REPO_NAME" --public --source=. --remote=origin \
      --description "Presenter kit for The Ghosts of Chinatown"
  fi
fi

if [[ ! -f CNAME ]]; then
  echo "$CUSTOM_DOMAIN" > CNAME
  git add CNAME
  git commit -m "Add GitHub Pages custom domain" || true
fi

git push -u origin main

echo "Enabling GitHub Pages (branch main, root)…"
gh api "repos/$USER/$REPO_NAME/pages" -X POST \
  -f build_type=legacy \
  -f source[branch]=main \
  -f source[path]=/ 2>/dev/null || \
  gh api "repos/$USER/$REPO_NAME/pages" -X PUT \
  -f build_type=legacy \
  -f source[branch]=main \
  -f source[path]=/

gh api "repos/$USER/$REPO_NAME/pages" -X PUT -f cname="$CUSTOM_DOMAIN" 2>/dev/null || true

echo ""
echo "Done."
echo "  GitHub:     https://github.com/$USER/$REPO_NAME"
echo "  Pages URL:  https://$USER.github.io/$REPO_NAME/"
echo "  Custom:     https://$CUSTOM_DOMAIN (after GoDaddy CNAME → $USER.github.io)"
echo ""
echo "GoDaddy DNS: CNAME  ghost  →  $USER.github.io"
