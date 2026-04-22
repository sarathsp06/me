import manifest from '../generated/image-manifest.json';

/**
 * Resolves a clean image path to its content-hashed equivalent.
 * Use for frontmatter/runtime image paths that Vite can't transform.
 *
 * @example
 *   resolveImage('/images/blog/wolfgangsee-cover.jpg')
 *   // => '/images/blog/wolfgangsee-cover-10596858.jpg'
 */
export function resolveImage(path: string): string {
  return (manifest as Record<string, string>)[path] ?? path;
}
