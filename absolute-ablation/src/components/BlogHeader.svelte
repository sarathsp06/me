<script lang="ts">
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
      <a href="/blog" class="nav-link active">Blog</a>
      <a href="/travel" class="nav-link">Travel</a>
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
    background: rgba(250, 250, 250, 0.5);
    backdrop-filter: blur(0px);
  }
  .blog-header.scrolled {
    border-bottom-color: #e5e7eb;
    background: rgba(255, 255, 255, 0.85);
    backdrop-filter: blur(12px);
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.04);
  }
  .header-inner {
    max-width: 56rem;
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
    font-size: 0.875rem;
    color: #9ca3af;
    text-decoration: none;
    transition: color 0.2s ease;
  }
  .back-link:hover {
    color: #4b5563;
  }
  .header-nav {
    display: flex;
    gap: 0.25rem;
    background: #f3f4f6;
    border-radius: 8px;
    padding: 0.2rem;
  }
  .nav-link {
    padding: 0.4rem 1rem;
    font-size: 0.8rem;
    font-weight: 500;
    color: #6b7280;
    text-decoration: none;
    border-radius: 6px;
    transition: all 0.2s ease;
  }
  .nav-link:hover {
    color: #111827;
  }
  .nav-link.active {
    background: white;
    color: #111827;
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.08);
  }
  .header-spacer {
    width: 4rem;
  }
</style>
