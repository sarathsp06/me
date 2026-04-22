import { readdirSync, readFileSync, writeFileSync, mkdirSync, rmSync, existsSync } from 'node:fs';
import { createHash } from 'node:crypto';
import { join, extname, basename } from 'node:path';
import { copyFileSync } from 'node:fs';

const SRC_DIR = 'src/assets/blog-images';
const OUT_DIR = 'public/images/blog';
const MANIFEST_PATH = 'src/generated/image-manifest.json';

// Ensure output dirs exist
mkdirSync(OUT_DIR, { recursive: true });
mkdirSync('src/generated', { recursive: true });

// Clean previous hashed files
if (existsSync(OUT_DIR)) {
  const existing = readdirSync(OUT_DIR);
  for (const file of existing) {
    rmSync(join(OUT_DIR, file));
  }
}

// Process images
const manifest = {};
const files = readdirSync(SRC_DIR).filter(f => /\.(jpg|jpeg|png|gif|webp|avif|svg)$/i.test(f));

for (const file of files) {
  const srcPath = join(SRC_DIR, file);
  const content = readFileSync(srcPath);
  const hash = createHash('md5').update(content).digest('hex').slice(0, 8);

  const ext = extname(file);
  const name = basename(file, ext);
  const hashedName = `${name}-${hash}${ext}`;
  const outPath = join(OUT_DIR, hashedName);

  copyFileSync(srcPath, outPath);

  // Map clean path -> hashed path
  manifest[`/images/blog/${file}`] = `/images/blog/${hashedName}`;

  console.log(`  ${file} -> ${hashedName}`);
}

writeFileSync(MANIFEST_PATH, JSON.stringify(manifest, null, 2) + '\n');
console.log(`\nManifest written to ${MANIFEST_PATH} (${Object.keys(manifest).length} images)`);
