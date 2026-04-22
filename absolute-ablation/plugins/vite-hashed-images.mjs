import { readFileSync, existsSync } from 'node:fs';

const MANIFEST_PATH = 'src/generated/image-manifest.json';

/**
 * Vite plugin that rewrites /images/blog/foo.jpg references
 * to their content-hashed equivalents across all file types.
 *
 * Works in .astro, .svelte, .mdx, .ts, .js — anything Vite transforms.
 */
export function viteHashedImages() {
  let manifest = {};

  return {
    name: 'vite-hashed-images',
    enforce: /** @type {const} */ ('pre'),

    buildStart() {
      if (existsSync(MANIFEST_PATH)) {
        manifest = JSON.parse(readFileSync(MANIFEST_PATH, 'utf-8'));
      } else {
        console.warn('[vite-hashed-images] No manifest found. Run `npm run hash-images` first.');
      }
    },

    transform(code, id) {
      // Only process files that might contain image references
      if (!/\.(astro|svelte|mdx|md|ts|js|tsx|jsx)$/.test(id)) return null;

      let replaced = code;
      for (const [clean, hashed] of Object.entries(manifest)) {
        if (replaced.includes(clean)) {
          replaced = replaced.replaceAll(clean, hashed);
        }
      }

      if (replaced !== code) {
        return { code: replaced, map: null };
      }
      return null;
    },
  };
}
