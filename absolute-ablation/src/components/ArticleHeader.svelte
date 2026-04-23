<script lang="ts">
  interface Props {
    title: string;
    description: string;
    pubDate: string;
    tags?: string[];
    readingTime?: string;
  }

  let { title, description, pubDate, tags = [], readingTime = '' }: Props = $props();

  let visible = $state(false);

  $effect(() => {
    setTimeout(() => { visible = true; }, 100);
  });
</script>

<header class={`mb-12 pb-8 transition-all duration-[600ms] ease-[cubic-bezier(0.4,0,0.2,1)] ${visible ? 'opacity-100 translate-y-0' : 'opacity-0 translate-y-4'}`}>
  <div class="flex flex-wrap items-center gap-2 mb-5">
    {#each tags as tag}
      <span class="inline-flex px-3 py-1 font-body text-[0.7rem] font-semibold uppercase tracking-[0.06em] bg-paper-surface text-paper-accent border border-paper-border">{tag}</span>
    {/each}
    {#if readingTime}
      <span class="inline-flex items-center font-body text-[0.85rem] text-paper-muted">
        <svg class="inline-block w-3.5 h-3.5 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24" stroke-width="2">
          <circle cx="12" cy="12" r="10"/>
          <path d="M12 6v6l4 2" stroke-linecap="round"/>
        </svg>
        {readingTime}
      </span>
    {/if}
  </div>

  <h1 class="font-display text-[2rem] md:text-[2.5rem] font-bold text-paper-ink leading-[1.2] mb-4 tracking-[-0.01em]">{title}</h1>
  <p class="font-body text-[1.15rem] italic text-paper-muted leading-[1.7] max-w-[36rem]">{description}</p>

  <div class="mt-6">
    <time class="inline-flex items-center font-body text-[0.9rem] text-paper-muted">
      <svg class="inline-block w-3.5 h-3.5 mr-1.5 opacity-40" fill="none" stroke="currentColor" viewBox="0 0 24 24" stroke-width="2">
        <rect x="3" y="4" width="18" height="18" rx="2" ry="2"/>
        <line x1="16" y1="2" x2="16" y2="6"/>
        <line x1="8" y1="2" x2="8" y2="6"/>
        <line x1="3" y1="10" x2="21" y2="10"/>
      </svg>
      {pubDate}
    </time>
    <div class="mt-6 h-px bg-paper-border"></div>
  </div>
</header>
