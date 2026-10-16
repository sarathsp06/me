// @ts-check
import { defineConfig } from 'astro/config';
import tailwindcss from '@tailwindcss/vite';
import svelte from '@astrojs/svelte';
import mdx from '@astrojs/mdx';
import { viteHashedImages } from './plugins/vite-hashed-images.mjs';

// https://astro.build/config
export default defineConfig({
  output: 'static',
  redirects: {
    '/projects/sparrow': 'https://sarathsp06.github.io/sparrow/',
  },
  integrations: [svelte(), mdx()],
  vite: {
    plugins: [tailwindcss(), viteHashedImages()]
  }
});
