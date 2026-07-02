import { defineCollection, z } from 'astro:content';
import { glob } from 'astro/loaders';

const articles = defineCollection({
  loader: glob({ pattern: '**/*.md', base: './src/content/articles' }),
  schema: z.object({
    title: z.string(),
    slug: z.string(),
    description: z.string(),
    publishDate: z.coerce.date(),
    updatedDate: z.coerce.date().optional(),
    category: z.string(),
    tags: z.array(z.string()).default([]),
    author: z.string().default('よけいラボ編集部'),
    participants: z.array(z.string()).default([]),
    eyecatch: z.string().optional(),
    eyecatchAlt: z.string().optional(),
    draft: z.boolean().default(false),
  }),
});

export const collections = { articles };
