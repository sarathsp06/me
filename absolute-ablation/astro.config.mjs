// @ts-check
import { defineConfig } from 'astro/config';
import tailwindcss from '@tailwindcss/vite';
import svelte from '@astrojs/svelte';
import mdx from '@astrojs/mdx';
import { viteHashedImages } from './plugins/vite-hashed-images.mjs';

// https://astro.build/config
export default defineConfig({
  output: 'static',
  integrations: [svelte(), mdx()],
  vite: {
    plugins: [tailwindcss(), viteHashedImages()]
  }
});
