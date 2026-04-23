<script lang="ts">
  let isVisible = $state(false);
  let showBackToTop = $state(false);

  $effect(() => {
    setTimeout(() => {
      isVisible = true;
    }, 300);

    function handleScroll() {
      showBackToTop = window.scrollY > 600;
    }
    window.addEventListener("scroll", handleScroll, { passive: true });
    return () => window.removeEventListener("scroll", handleScroll);
  });

  function scrollToTop() {
    window.scrollTo({ top: 0, behavior: "smooth" });
  }
</script>

<footer
  class={`border-t border-paper-border bg-paper-bg transition-all duration-500 ease-in-out ${isVisible ? "opacity-100 translate-y-0" : "opacity-0 translate-y-3"}`}
>
  <div class="max-w-3xl mx-auto pt-12 pb-8 px-6">
    <div class="mb-8">
      <p class="font-display text-base font-semibold text-paper-ink mb-2">
        Sarath Sadasivan Pillai
      </p>
      <p
        class="font-body text-[0.9rem] text-paper-muted max-w-md leading-relaxed"
      >
        Writing about software engineering, distributed systems, and building
        things that work.
      </p>
    </div>

    <div class="flex flex-wrap gap-6 mb-8 pb-8 border-b border-paper-border">
      <a
        href="/blog"
        class="font-body text-[0.85rem] font-medium text-paper-muted no-underline transition-colors duration-200 ease-in-out hover:text-paper-accent"
        >Blog</a
      >
      <a
        href="/travel"
        class="font-body text-[0.85rem] font-medium text-paper-muted no-underline transition-colors duration-200 ease-in-out hover:text-paper-accent"
        >Travel</a
      >
      <a
        href="https://github.com/sarathsp06"
        target="_blank"
        rel="noopener"
        class="font-body text-[0.85rem] font-medium text-paper-muted no-underline transition-colors duration-200 ease-in-out hover:text-paper-accent"
        >GitHub</a
      >
      <a
        href="https://www.linkedin.com/in/sarathsp/"
        target="_blank"
        rel="noopener"
        class="font-body text-[0.85rem] font-medium text-paper-muted no-underline transition-colors duration-200 ease-in-out hover:text-paper-accent"
        >LinkedIn</a
      >
    </div>

    <div class="flex items-center justify-between">
      <p
        class="font-body text-[0.8rem] text-paper-border font-variant-small-caps tracking-[0.03em]"
        style="font-variant: small-caps"
      >
        &copy; {new Date().getFullYear()} Sarath Sadasivan Pillai
      </p>
    </div>
  </div>
</footer>

{#if showBackToTop}
  <button
    class="fixed bottom-8 right-8 w-11 h-11 rounded-full border border-paper-border bg-paper-bg text-paper-muted cursor-pointer flex items-center justify-center shadow-[0_2px_8px_rgba(0,0,0,0.06)] transition-all duration-300 ease-in-out z-30 animate-[fadeIn_0.3s_ease] hover:-translate-y-0.5 hover:shadow-[0_4px_12px_rgba(0,0,0,0.1)] hover:text-paper-accent hover:border-paper-accent"
    onclick={scrollToTop}
    aria-label="Back to top"
  >
    <svg
      class="w-4 h-4"
      fill="none"
      stroke="currentColor"
      viewBox="0 0 24 24"
      stroke-width="2"
    >
      <path
        stroke-linecap="round"
        stroke-linejoin="round"
        d="M5 10l7-7m0 0l7 7m-7-7v18"
      />
    </svg>
  </button>
{/if}
