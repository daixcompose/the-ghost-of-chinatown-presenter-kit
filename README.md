# The Ghosts of Chinatown — presenter site

- `index.html` — full presenter page
- `fonts/` — Migra web fonts
- `assets/daixcompose-logo.png` — header logo on the presenter page
- `assets/ghosts-of-chinatown-header.png` — header / hero background art
- `assets/premiere-cast.png` — cast photo beside premiere-cast notice
- `assets/audio/` — movement excerpt MP3s (01–10) linked from the presenter page
- `assets/visuals/` — sample projection stills (01–04) below the roll-call note
- `assets/team/` — premiere team headshots (circular on the artists section)
- `assets/engagement/` — outreach photos slideshow at the end of the artists section

**Change colors or fonts:** search for `BRAND COLORS & FONTS` near the top of `index.html`.

**Preview:** open `index.html` in your browser (or run a local static server).

**Publish to GitHub Pages:** from macOS **Terminal** (Cursor’s sandbox cannot complete GitHub login):

```bash
cd "/Users/daixuanai/Library/CloudStorage/Dropbox/DaixCompose/Website/The Ghosts of Chinatown/ghost-of-chinatown-site"
./scripts/publish-to-github.sh
```

That script signs in with `gh`, creates `ghosts-of-chinatown-site`, pushes `main`, enables Pages, and adds `CNAME` for `ghost.daixcompose.com`. Point GoDaddy **CNAME** `ghost` → `YOUR_USERNAME.github.io`.

**Later updates:** `git add -A && git commit -m "…" && git push`
