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

<header class={`sticky top-0 z-40 border-b transition-all duration-300 ease-in-out ${scrolled ? 'border-paper-border bg-[rgba(250,248,245,0.92)] backdrop-blur-[12px] shadow-[0_1px_3px_rgba(0,0,0,0.04)]' : 'border-transparent bg-[rgba(250,248,245,0.5)] backdrop-blur-0'}`}>
  <div class="max-w-3xl mx-auto px-6 py-3.5 flex items-center justify-between">
    <a href="/" class="flex items-center gap-2 font-body text-[0.9rem] text-paper-muted no-underline transition-colors duration-200 ease-in-out hover:text-paper-accent">
      <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24" stroke-width="2">
        <path stroke-linecap="round" stroke-linejoin="round" d="M10 19l-7-7m0 0l7-7m-7 7h18"/>
      </svg>
      <span>Home</span>
    </a>
    <nav class="flex gap-1 bg-paper-surface rounded-md p-[0.2rem] border border-paper-border">
      <a href="/blog" class={`px-4 py-1.5 font-body text-[0.85rem] font-medium no-underline rounded transition-all duration-200 ease-in-out hover:text-paper-ink ${activePage === 'blog' ? 'bg-paper-bg text-paper-ink shadow-[0_1px_2px_rgba(0,0,0,0.06)]' : 'text-paper-muted'}`}>Blog</a>
      <a href="/travel" class={`px-4 py-1.5 font-body text-[0.85rem] font-medium no-underline rounded transition-all duration-200 ease-in-out hover:text-paper-ink ${activePage === 'travel' ? 'bg-paper-bg text-paper-ink shadow-[0_1px_2px_rgba(0,0,0,0.06)]' : 'text-paper-muted'}`}>Travel</a>
    </nav>
    <div class="w-16"></div>
  </div>
</header>
