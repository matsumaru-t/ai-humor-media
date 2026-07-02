# AI Humor Media Site

Static article media for AI Humor Media.

## Stack

- Astro
- Markdown content collections
- Static images under `public/images`
- RSS and sitemap
- GitHub Pages deployment via GitHub Actions

## Local Commands

```powershell
npm install
npm run dev
npm run build
```

## Content Workflow

1. Keep rough drafts in the parent workspace under `runs/`.
2. Move only publishable versions into `src/content/articles/`.
3. Put article images under `public/images/<slug>/`.
4. Set `draft: false` when the article is ready to publish.
5. Run `npm run build` before pushing.

## GitHub Pages

Production URL:

```text
https://matsumaru-t.github.io/ai-humor-media/
```

GitHub Actions builds from the `site` directory and publishes `site/dist`.
The production build uses:

```text
SITE_URL=https://matsumaru-t.github.io
SITE_BASE=/ai-humor-media
```

For a custom domain later, update `SITE_URL`, `SITE_BASE`, and `public/robots.txt`.
