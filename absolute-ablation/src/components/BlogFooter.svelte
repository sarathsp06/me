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
      <div class="footer-brand">
        <span class="brand-text">sarath@unix:~$</span>
        <span class="brand-cursor"></span>
      </div>
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
    border-top: 1px solid #e5e7eb;
    background: white;
    opacity: 0;
    transform: translateY(12px);
    transition: all 0.5s ease;
  }
  .blog-footer.visible {
    opacity: 1;
    transform: translateY(0);
  }
  .footer-inner {
    max-width: 56rem;
    margin: 0 auto;
    padding: 3rem 1.5rem 2rem;
  }
  .footer-content {
    margin-bottom: 2rem;
  }
  .footer-brand {
    display: flex;
    align-items: center;
    gap: 0.25rem;
    margin-bottom: 0.75rem;
  }
  .brand-text {
    font-family: 'Fira Code', monospace;
    font-size: 0.875rem;
    font-weight: 600;
    color: #111827;
  }
  .brand-cursor {
    display: inline-block;
    width: 8px;
    height: 16px;
    background: #4ade80;
    animation: blink 1s step-end infinite;
  }
  @keyframes blink {
    50% { opacity: 0; }
  }
  .footer-desc {
    font-size: 0.875rem;
    color: #9ca3af;
    max-width: 28rem;
    line-height: 1.6;
  }
  .footer-links {
    display: flex;
    flex-wrap: wrap;
    gap: 1.5rem;
    margin-bottom: 2rem;
    padding-bottom: 2rem;
    border-bottom: 1px solid #f3f4f6;
  }
  .footer-link {
    font-size: 0.8rem;
    font-weight: 500;
    color: #6b7280;
    text-decoration: none;
    transition: color 0.2s ease;
  }
  .footer-link:hover {
    color: #111827;
  }
  .footer-bottom {
    display: flex;
    align-items: center;
    justify-content: space-between;
  }
  .copyright {
    font-size: 0.75rem;
    color: #d1d5db;
  }

  .back-to-top {
    position: fixed;
    bottom: 2rem;
    right: 2rem;
    width: 2.75rem;
    height: 2.75rem;
    border-radius: 50%;
    border: 1px solid #e5e7eb;
    background: white;
    color: #6b7280;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
    transition: all 0.3s ease;
    z-index: 30;
    animation: fadeIn 0.3s ease;
  }
  .back-to-top:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(0, 0, 0, 0.12);
    color: #3b82f6;
    border-color: #93c5fd;
  }
  @keyframes fadeIn {
    from { opacity: 0; transform: translateY(8px); }
    to { opacity: 1; transform: translateY(0); }
  }
</style>
