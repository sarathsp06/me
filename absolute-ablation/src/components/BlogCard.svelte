<script lang="ts">
  interface Props {
    title: string;
    description: string;
    href: string;
    tags?: string[];
    readingTime?: string;
    pubDate?: string;
    external?: boolean;
    index?: number;
  }

  let { title, description, href, tags = [], readingTime = '', pubDate = '', external = false, index = 0 }: Props = $props();

  let hovered = $state(false);
</script>

<a
  {href}
  class="block no-underline text-inherit animate-[slideUp_0.5s_ease_both]"
  target={external ? '_blank' : undefined}
  rel={external ? 'noopener noreferrer' : undefined}
  onmouseenter={() => hovered = true}
  onmouseleave={() => hovered = false}
  style="animation-delay: {index * 80}ms"
>
  <article class={`relative border bg-paper-bg overflow-hidden transition-all duration-300 ease-[cubic-bezier(0.4,0,0.2,1)] px-8 py-7 ${hovered ? 'border-paper-accent shadow-[0_4px_12px_rgba(139,69,19,0.06)] -translate-y-px' : 'border-paper-border'}`}>
    <div class="flex flex-wrap items-center gap-2 mb-3.5">
      {#each tags as tag}
        <span class="inline-flex py-[0.2rem] px-2.5 font-body text-[0.7rem] font-semibold uppercase tracking-[0.04em] bg-paper-surface text-paper-accent border border-paper-border">{tag}</span>
      {/each}
      {#if readingTime}
        <span class="text-paper-border text-xs">&middot;</span>
        <span class="font-body text-[0.8rem] text-paper-muted">{readingTime}</span>
      {/if}
    </div>

    <h3 class={`font-display text-xl font-bold leading-[1.4] mb-2.5 transition-colors duration-200 ease-in-out ${hovered ? 'text-paper-accent' : 'text-paper-ink'}`}>
      {title}
      {#if external}
        <svg class="inline-block w-3.5 h-3.5 ml-1 opacity-40" fill="none" stroke="currentColor" viewBox="0 0 24 24" stroke-width="2">
          <path stroke-linecap="round" stroke-linejoin="round" d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14"/>
        </svg>
      {/if}
    </h3>

    <p class="font-body text-[0.95rem] text-paper-muted leading-[1.7] mb-4">{description}</p>

    <div class="flex items-center justify-between">
      <time class="font-body text-[0.85rem] text-paper-muted">{pubDate}</time>
      <span class={`flex items-center gap-1.5 font-body text-[0.85rem] font-semibold text-paper-accent transition-all duration-300 ease-in-out ${hovered ? 'opacity-100 translate-x-0' : 'opacity-0 -translate-x-2'}`}>
        {external ? 'Read on Medium' : 'Read more'}
        <svg class={`w-4 h-4 transition-transform duration-200 ease-in-out ${hovered ? 'translate-x-0.5' : ''}`} fill="none" stroke="currentColor" viewBox="0 0 24 24" stroke-width="2">
          <path stroke-linecap="round" stroke-linejoin="round" d="M17 8l4 4m0 0l-4 4m4-4H3"/>
        </svg>
      </span>
    </div>

    <div class={`absolute bottom-0 left-0 right-0 h-0.5 bg-paper-accent origin-left transition-transform duration-300 ease-[cubic-bezier(0.4,0,0.2,1)] ${hovered ? 'scale-x-100' : 'scale-x-0'}`}></div>
  </article>
</a>
