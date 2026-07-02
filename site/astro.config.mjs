import { defineConfig } from 'astro/config';
import sitemap from '@astrojs/sitemap';

export default defineConfig({
  site: process.env.SITE_URL ?? 'http://127.0.0.1:4321',
  base: process.env.SITE_BASE ?? '/',
  integrations: [sitemap()],
});
