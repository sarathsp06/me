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

<nav class="toc-nav">
  <a href="/" class="back-link">
    <svg class="w-3.5 h-3.5" fill="none" stroke="currentColor" viewBox="0 0 24 24" stroke-width="2">
      <path stroke-linecap="round" stroke-linejoin="round" d="M10 19l-7-7m0 0l7-7m-7 7h18"/>
    </svg>
    Back to home
  </a>

  <p class="toc-heading">Contents</p>

  <ul class="toc-list">
    {#each items as item}
      <li>
        <button
          class="toc-link"
          class:active={activeId === item.id}
          class:indent={item.level === 3}
          onclick={() => scrollTo(item.id)}
        >
          <span class="toc-indicator"></span>
          {item.text}
        </button>
      </li>
    {/each}
  </ul>

  <div class="toc-footer">
    <svg class="inline-block w-3.5 h-3.5 mr-1 opacity-50" fill="none" stroke="currentColor" viewBox="0 0 24 24">
      <circle cx="12" cy="12" r="10" stroke-width="2"/>
      <path d="M12 6v6l4 2" stroke-width="2" stroke-linecap="round"/>
    </svg>
    {readingTime}
  </div>
</nav>

<style>
  .toc-nav {
    display: flex;
    flex-direction: column;
    height: 100%;
  }
  .back-link {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    font-size: 0.875rem;
    color: #9ca3af;
    margin-bottom: 1.5rem;
    transition: color 0.2s ease;
    text-decoration: none;
  }
  .back-link:hover {
    color: #4b5563;
  }
  .toc-heading {
    font-size: 0.65rem;
    text-transform: uppercase;
    letter-spacing: 0.1em;
    color: #9ca3af;
    font-weight: 700;
    margin-bottom: 0.75rem;
  }
  .toc-list {
    list-style: none;
    padding: 0;
    margin: 0;
    flex: 1;
    overflow-y: auto;
  }
  .toc-link {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    width: 100%;
    padding: 0.5rem 0.75rem;
    font-size: 0.8rem;
    color: #6b7280;
    border: none;
    background: none;
    cursor: pointer;
    border-radius: 0 6px 6px 0;
    transition: all 0.2s ease;
    text-align: left;
    line-height: 1.4;
  }
  .toc-link:hover {
    color: #111827;
    background: #f3f4f6;
  }
  .toc-link.indent {
    padding-left: 1.5rem;
    font-size: 0.75rem;
  }
  .toc-indicator {
    width: 3px;
    height: 16px;
    border-radius: 2px;
    background: transparent;
    flex-shrink: 0;
    transition: all 0.2s ease;
  }
  .toc-link.active {
    color: #2563eb;
    font-weight: 600;
    background: #eff6ff;
  }
  .toc-link.active .toc-indicator {
    background: linear-gradient(180deg, #3b82f6, #8b5cf6);
  }
  .toc-footer {
    margin-top: auto;
    padding-top: 1rem;
    border-top: 1px solid #f3f4f6;
    font-size: 0.75rem;
    color: #9ca3af;
    display: flex;
    align-items: center;
  }
</style>
