<script lang="ts">
  interface Props {
    activePage?: string;
  }

  let { activePage = 'blog' }: Props = $props();

  let scrolled = $state(false);

  $effect(() => {
    function handleScroll() {
      scrolled = window.scrollY > 20;
    }
    window.addEventListener('scroll', handleScroll, { passive: true });
    return () => window.removeEventListener('scroll', handleScroll);
  });
</script>

<header class="blog-header" class:scrolled>
  <div class="header-inner">
    <a href="/" class="back-link">
      <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24" stroke-width="2">
        <path stroke-linecap="round" stroke-linejoin="round" d="M10 19l-7-7m0 0l7-7m-7 7h18"/>
      </svg>
      <span>Home</span>
    </a>
    <nav class="header-nav">
      <a href="/blog" class="nav-link" class:active={activePage === 'blog'}>Blog</a>
      <a href="/travel" class="nav-link" class:active={activePage === 'travel'}>Travel</a>
    </nav>
    <div class="header-spacer"></div>
  </div>
</header>

<style>
  .blog-header {
    position: sticky;
    top: 0;
    z-index: 40;
    border-bottom: 1px solid transparent;
    transition: all 0.3s ease;
    background: rgba(250, 248, 245, 0.5);
    backdrop-filter: blur(0px);
  }
  .blog-header.scrolled {
    border-bottom-color: var(--color-paper-border);
    background: rgba(250, 248, 245, 0.92);
    backdrop-filter: blur(12px);
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.04);
  }
  .header-inner {
    max-width: 48rem;
    margin: 0 auto;
    padding: 0.875rem 1.5rem;
    display: flex;
    align-items: center;
    justify-content: space-between;
  }
  .back-link {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    font-family: 'Crimson Pro', Georgia, serif;
    font-size: 0.9rem;
    color: var(--color-paper-muted);
    text-decoration: none;
    transition: color 0.2s ease;
  }
  .back-link:hover {
    color: var(--color-paper-accent);
  }
  .header-nav {
    display: flex;
    gap: 0.25rem;
    background: var(--color-paper-surface);
    border-radius: 6px;
    padding: 0.2rem;
    border: 1px solid var(--color-paper-border);
  }
  .nav-link {
    padding: 0.4rem 1rem;
    font-family: 'Crimson Pro', Georgia, serif;
    font-size: 0.85rem;
    font-weight: 500;
    color: var(--color-paper-muted);
    text-decoration: none;
    border-radius: 4px;
    transition: all 0.2s ease;
  }
  .nav-link:hover {
    color: var(--color-paper-ink);
  }
  .nav-link.active {
    background: var(--color-paper-bg);
    color: var(--color-paper-ink);
    box-shadow: 0 1px 2px rgba(0, 0, 0, 0.06);
  }
  .header-spacer {
    width: 4rem;
  }
</style>
