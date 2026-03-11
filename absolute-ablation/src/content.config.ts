import { defineCollection } from 'astro:content';
import { glob } from 'astro/loaders';
import { z } from 'astro/zod';

const blog = defineCollection({
  loader: glob({ pattern: '**/*.{md,mdx}', base: './src/content/blog' }),
  schema: z.object({
    title: z.string(),
    description: z.string(),
    pubDate: z.coerce.date(),
    updatedDate: z.coerce.date().optional(),
    tags: z.array(z.string()).default([]),
    readingTime: z.string().optional(),
    external: z.string().optional(),
  }),
});

const travel = defineCollection({
  loader: glob({ pattern: '**/*.{md,mdx}', base: './src/content/travel' }),
  schema: z.object({
    title: z.string(),
    description: z.string(),
    pubDate: z.coerce.date(),
    updatedDate: z.coerce.date().optional(),
    location: z.string().optional(),
    tags: z.array(z.string()).default([]),
    coverImage: z.string().optional(),
    readingTime: z.string().optional(),
  }),
});

export const collections = { blog, travel };
