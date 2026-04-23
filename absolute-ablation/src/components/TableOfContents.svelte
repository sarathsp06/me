<script lang="ts">
  interface TocItem {
    id: string;
    text: string;
    level: number;
  }

  interface Props {
    readingTime?: string;
  }

  let { readingTime = '5 min read' }: Props = $props();

  let items: TocItem[] = $state([]);
  let activeId = $state('');

  $effect(() => {
    const headings = document.querySelectorAll('article h2, article h3');
    items = Array.from(headings).map((h) => {
      if (!h.id) {
        h.id = (h.textContent || '').toLowerCase().replace(/\s+/g, '-').replace(/[^\w-]/g, '');
      }
      return {
        id: h.id,
        text: h.textContent || '',
        level: h.tagName === 'H2' ? 2 : 3,
      };
    });

    const observer = new IntersectionObserver(
      (entries) => {
        for (const entry of entries) {
          if (entry.isIntersecting) {
            activeId = entry.target.id;
          }
        }
      },
      { rootMargin: '-80px 0px -70% 0px' }
    );

    headings.forEach((h) => observer.observe(h));
    return () => observer.disconnect();
  });

  function scrollTo(id: string) {
    const el = document.getElementById(id);
    if (el) {
      el.scrollIntoView({ behavior: 'smooth', block: 'start' });
    }
  }
</script>

<nav class="flex flex-col h-full">
  <a href="/" class="flex items-center gap-2 font-body text-[0.9rem] text-paper-muted mb-6 transition-colors duration-200 ease-in-out no-underline hover:text-paper-accent">
    <svg class="w-3.5 h-3.5" fill="none" stroke="currentColor" viewBox="0 0 24 24" stroke-width="2">
      <path stroke-linecap="round" stroke-linejoin="round" d="M10 19l-7-7m0 0l7-7m-7 7h18"/>
    </svg>
    Back to home
  </a>

  <p class="font-display text-[0.7rem] uppercase tracking-[0.1em] text-paper-muted font-bold mb-3">Contents</p>

  <ul class="list-none p-0 m-0 flex-1 overflow-y-auto">
    {#each items as item}
      <li>
        <button
          class={`flex items-center gap-2 w-full py-2 px-3 font-body text-left leading-[1.4] border-none bg-transparent cursor-pointer rounded-r transition-all duration-200 ease-in-out hover:text-paper-ink hover:bg-paper-surface ${item.level === 3 ? 'pl-6 text-[0.8rem]' : 'text-[0.85rem]'} ${activeId === item.id ? 'text-paper-accent font-semibold bg-paper-surface' : 'text-paper-muted'}`}
          onclick={() => scrollTo(item.id)}
        >
          <span class={`w-0.5 h-4 rounded-sm shrink-0 transition-all duration-200 ease-in-out ${activeId === item.id ? 'bg-paper-accent' : 'bg-transparent'}`}></span>
          {item.text}
        </button>
      </li>
    {/each}
  </ul>

  <div class="mt-auto pt-4 border-t border-paper-border font-body text-[0.8rem] text-paper-muted flex items-center">
    <svg class="inline-block w-3.5 h-3.5 mr-1 opacity-50" fill="none" stroke="currentColor" viewBox="0 0 24 24">
      <circle cx="12" cy="12" r="10" stroke-width="2"/>
      <path d="M12 6v6l4 2" stroke-width="2" stroke-linecap="round"/>
    </svg>
    {readingTime}
  </div>
</nav>
