# CLAUDE.md — org-kickstart-site

This is the documentation website for the [org-kickstart](https://github.com/primeharbor/org-kickstart) Terraform module.
It is built with [Hugo](https://gohugo.io/) (extended) and the [Docsy](https://www.docsy.dev/) theme, and is published at **https://aws-kickstart.org**.

---

## Tech Stack

| Tool | Version | Purpose |
|------|---------|---------|
| Hugo extended | ≥ 0.155.0 | Static site generator |
| Docsy | v0.14.3 | Hugo theme (loaded as a Go module) |
| Node.js / npm | any recent LTS | PostCSS / SCSS compilation |
| Go | ≥ 1.12 | Hugo module dependency management |

---

## Running Locally

All common tasks are in the **Makefile**. Use `make` rather than invoking Hugo directly.

```bash
cd org-kickstart-site
make npm       # install Node dependencies (first time only)
make test      # start dev server at http://localhost:1319/ (opens browser automatically)
make test-drafts   # same, but also renders draft and future-dated content
make build-static  # build the static site to public/
make clean     # remove public/ and resources/_gen/ (build artefacts)
```

The dev server runs on **port 1319** (not Hugo's default 1313) with `--disableFastRender` for reliable live reload.
Hugo live-reloads on every file save. The `public/` directory is regenerated on each build — do not edit it by hand.

---

## Directory Structure

```
org-kickstart-site/
├── hugo.yaml                  # Primary Hugo config (baseURL, params, nav, etc.)
├── config.yaml                # Legacy duplicate — hugo.yaml takes precedence; candidate for removal
├── content/en/                # All English-language content (the only active language)
│   ├── _index.md              # Home page (hero + feature blocks)
│   ├── docs/                  # Documentation section
│   │   ├── getting-started/   # Bootstrap & first deploy guides
│   │   ├── concepts.md        # Core concepts
│   │   ├── overview.md        # What Org Kickstart does
│   │   ├── tasks/             # How-to guides (adding accounts, policies, etc.)
│   │   ├── reference/         # Parameter reference
│   │   └── tutorials/         # Step-by-step tutorials
│   ├── blog/
│   │   ├── news/              # General news posts
│   │   └── releases/          # Release notes
│   ├── community/             # Community page
│   └── about/                 # About page
├── static/
│   └── images/
│       └── KickControlTower.png   # Project architecture diagram; used as social card & hero image
├── assets/scss/
│   ├── _variables_project.scss    # Docsy SCSS variable overrides
│   └── _styles_project.scss       # Project-specific CSS
├── layouts/                       # Hugo template overrides
│   ├── _markup/render-heading.html
│   └── home.redirects
├── resources/_gen/                # Hugo image/asset cache — auto-generated, do not commit
└── public/                        # Built site output — auto-generated, do not commit
```

### Languages

Only `content/en/` is active. The `content/fa/` (Persian) and `content/no/` (Norwegian) directories are
leftover Docsy example content and are candidates for deletion — they are not referenced in `hugo.yaml`.

---

## Content Authoring

### Page Bundles vs. Leaf Pages

- **Leaf pages** (single `.md` file): use for simple documentation pages with no attached images.
- **Page bundles** (directory with `index.md`): use when a page needs attached images, especially a card/hero image.
  - Name the hero image `featured-<descriptive-name>.<ext>` inside the bundle directory.
  - Docsy automatically uses it as the card thumbnail on listing pages.

### Blog / News Posts

- Posts live under `content/en/blog/news/` or `content/en/blog/releases/`.
- Use a page bundle (`my-post/index.md`) if you want a featured image on the post card.
- Front matter date drives the URL permalink (`/:section/:year/:month/:day/:slug`).

### Images

- Static images (diagrams, logos) belong in `static/images/`.
- Reference them in Markdown as `/images/filename.png` (no `/static` prefix).
- The architecture diagram `KickControlTower.png` lives at `static/images/KickControlTower.png`
  and is referenced in `content/en/docs/overview.md` and configured as the social card image in `hugo.yaml`.

### Shortcodes

This site uses standard Docsy shortcodes. Commonly used ones:

```
{{% blocks/cover title="..." image_anchor="top" height="full" %}}
{{% blocks/lead %}}
{{% blocks/section color="primary" type="row" %}}
{{% blocks/feature title="..." icon="fa-..." url="..." %}}
{{% _param description %}}
{{% _param btn-lg primary %}}
```

---

## Configuration Notes (`hugo.yaml`)

- **`baseURL`**: `https://aws-kickstart.org`
- **`github_repo`** / **`github_project_repo`**: both point to `https://github.com/primeharbor/org-kickstart` — this powers the "Edit this page" and "Open an issue" links on every doc page.
- **`params.images`**: set to `[images/KickControlTower.png]` for Open Graph / social card.
- **`offlineSearch: true`**: uses Lunr.js; no external search service required.
- **`enableGitInfo: true`**: populates `.Lastmod` on pages from Git history. Requires a full (non-shallow) clone to work correctly.
- **Copyright**: Chris Farris / PrimeHarbor Technologies, LLC — Apache 2.0 from 2023.

---

## Community Contributions

This site is open to contributions from the community. When helping contributors:

1. Direct them to fork `https://github.com/primeharbor/org-kickstart` (the site lives inside the monorepo).
2. Edits go under `org-kickstart-site/content/en/`.
3. Preview with `hugo server` before submitting a PR.
4. The **Edit this page** button on every doc page links directly to the source file on GitHub.
5. For significant structural changes, open a GitHub Discussion first.

---

## Files That Can Be Deleted

| Path | Reason |
|------|--------|
| `public/` | Build output — regenerated by `hugo` |
| `resources/_gen/` | Hugo image/asset cache — auto-regenerated |


---

## Common Commands

Prefer `make` targets over raw Hugo commands:

```bash
make npm            # Install JS dependencies (first time / after package.json changes)
make test           # Dev server at http://localhost:1319/ — opens browser automatically
make test-drafts    # Dev server including drafts and future-dated content
make build-static   # Build the static site to public/
make clean          # Remove public/ and resources/_gen/
```

Lower-level Hugo commands (when you need them):

```bash
# Check Hugo module dependency tree
hugo mod graph

# Update Docsy theme to latest
hugo mod get -u github.com/google/docsy
hugo mod tidy
```
