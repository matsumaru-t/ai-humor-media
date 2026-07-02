# Operations

This site is the final publishing surface for AI Humor Media.

## Publishing Model

Keep production and publishing separate:

- `../runs/`: drafts, trials, QA notes, rejected versions
- `src/content/articles/`: publishable article Markdown only
- `public/images/<slug>/`: article images used by the published page

Do not move an article into `src/content/articles/` until it has passed the editor gate or a human has explicitly approved it.

## Daily Workflow

1. Run the content pipeline from the parent workspace.
2. Keep drafts and review output under `../runs/`.
3. Generate and inspect image assets.
4. Promote only the final article into `src/content/articles/`.
5. Run:

```powershell
npm run build
```

6. Commit/push the site changes. GitHub Actions deploys the static build to GitHub Pages.

## Article Frontmatter

```yaml
---
title: "Article title"
slug: "article-slug"
description: "Short summary for cards, RSS, and SEO."
publishDate: "2026-07-02"
category: "実験風コラム"
tags: ["会議", "相づち"]
eyecatch: "/images/<slug>/eyecatch.png"
eyecatchAlt: "Alt text"
draft: false
---
```

## Image Rules

- Use real generated or sourced bitmap assets, not layout placeholders.
- Keep images under `public/images/<slug>/`.
- Avoid real logos, celebrity likenesses, trademarks, real company interiors, and news-photo styling.
- Check images before publish; set `asset_rights_all_checked=true` only after inspection.

## Deployment

GitHub Pages settings:

- Repository: `matsumaru-t/ai-humor-media`
- Branch: `main`
- Build workflow: `.github/workflows/deploy.yml`
- Production URL: `https://matsumaru-t.github.io/ai-humor-media/`

For a custom domain later, update:

- `SITE_URL` and `SITE_BASE` in `.github/workflows/deploy.yml`
- `public/robots.txt`

## Free Services

- Hosting: GitHub Pages Free
- Repository: GitHub Free
- Analytics: privacy-friendly static analytics can be added later
- Search: Google Search Console
- Domain: optional paid domain later
