<script lang="ts">
  let isVisible = $state(false);
  let showBackToTop = $state(false);

  $effect(() => {
    setTimeout(() => { isVisible = true; }, 300);

    function handleScroll() {
      showBackToTop = window.scrollY > 600;
    }
    window.addEventListener('scroll', handleScroll, { passive: true });
    return () => window.removeEventListener('scroll', handleScroll);
  });

  function scrollToTop() {
    window.scrollTo({ top: 0, behavior: 'smooth' });
  }
</script>

<footer class="blog-footer" class:visible={isVisible}>
  <div class="footer-inner">
    <div class="footer-content">
      <p class="footer-brand">Sarath Sadasivan Pillai</p>
      <p class="footer-desc">Writing about software engineering, distributed systems, and building things that work.</p>
    </div>

    <div class="footer-links">
      <a href="/blog" class="footer-link">Blog</a>
      <a href="/travel" class="footer-link">Travel</a>
      <a href="https://github.com/sarathsp06" target="_blank" rel="noopener" class="footer-link">GitHub</a>
      <a href="https://www.linkedin.com/in/sarathsp/" target="_blank" rel="noopener" class="footer-link">LinkedIn</a>
    </div>

    <div class="footer-bottom">
      <p class="copyright">&copy; {new Date().getFullYear()} Sarath Sadasivan Pillai</p>
    </div>
  </div>
</footer>

{#if showBackToTop}
  <button class="back-to-top" onclick={scrollToTop} aria-label="Back to top">
    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24" stroke-width="2">
      <path stroke-linecap="round" stroke-linejoin="round" d="M5 10l7-7m0 0l7 7m-7-7v18"/>
    </svg>
  </button>
{/if}

<style>
  .blog-footer {
    border-top: 1px solid var(--color-paper-border);
    background: var(--color-paper-bg);
    opacity: 0;
    transform: translateY(12px);
    transition: all 0.5s ease;
  }
  .blog-footer.visible {
    opacity: 1;
    transform: translateY(0);
  }
  .footer-inner {
    max-width: 48rem;
    margin: 0 auto;
    padding: 3rem 1.5rem 2rem;
  }
  .footer-content {
    margin-bottom: 2rem;
  }
  .footer-brand {
    font-family: 'Playfair Display', Georgia, serif;
    font-size: 1rem;
    font-weight: 600;
    color: var(--color-paper-ink);
    margin-bottom: 0.5rem;
  }
  .footer-desc {
    font-family: 'Crimson Pro', Georgia, serif;
    font-size: 0.9rem;
    color: var(--color-paper-muted);
    max-width: 28rem;
    line-height: 1.6;
  }
  .footer-links {
    display: flex;
    flex-wrap: wrap;
    gap: 1.5rem;
    margin-bottom: 2rem;
    padding-bottom: 2rem;
    border-bottom: 1px solid var(--color-paper-border);
  }
  .footer-link {
    font-family: 'Crimson Pro', Georgia, serif;
    font-size: 0.85rem;
    font-weight: 500;
    color: var(--color-paper-muted);
    text-decoration: none;
    transition: color 0.2s ease;
  }
  .footer-link:hover {
    color: var(--color-paper-accent);
  }
  .footer-bottom {
    display: flex;
    align-items: center;
    justify-content: space-between;
  }
  .copyright {
    font-family: 'Crimson Pro', Georgia, serif;
    font-size: 0.8rem;
    color: var(--color-paper-border);
    font-variant: small-caps;
    letter-spacing: 0.03em;
  }

  .back-to-top {
    position: fixed;
    bottom: 2rem;
    right: 2rem;
    width: 2.75rem;
    height: 2.75rem;
    border-radius: 50%;
    border: 1px solid var(--color-paper-border);
    background: var(--color-paper-bg);
    color: var(--color-paper-muted);
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06);
    transition: all 0.3s ease;
    z-index: 30;
    animation: fadeIn 0.3s ease;
  }
  .back-to-top:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    color: var(--color-paper-accent);
    border-color: var(--color-paper-accent);
  }
  @keyframes fadeIn {
    from { opacity: 0; transform: translateY(8px); }
    to { opacity: 1; transform: translateY(0); }
  }
</style>
