import rss from '@astrojs/rss';
import { getCollection } from 'astro:content';
import { withBase } from '../lib/paths';

export async function GET(context) {
  const articles = (await getCollection('articles', ({ data }) => !data.draft)).sort(
    (a, b) => b.data.publishDate.valueOf() - a.data.publishDate.valueOf(),
  );
  const siteUrl = new URL(withBase('/'), context.site).toString();

  return rss({
    title: 'AI Humor Media',
    description: '真剣にバカなことを検証する、日本語ユーモア記事メディア。',
    site: siteUrl,
    items: articles.map((article) => ({
      title: article.data.title,
      description: article.data.description,
      pubDate: article.data.publishDate,
      link: new URL(withBase(`/articles/${article.data.slug}/`), context.site).toString(),
    })),
    customData: '<language>ja</language>',
  });
}
