<script lang="ts">
  interface PostData {
    title: string;
    description: string;
    tags: string[];
    readingTime?: string;
    pubDate: string;
    external?: string;
    href: string;
  }

  interface Props {
    tags?: string[];
    posts?: PostData[];
  }

  let { tags = [], posts = [] }: Props = $props();

  let selectedTag: string | null = $state(null);

  let filteredPosts = $derived(
    selectedTag
      ? posts.filter(p => p.tags.includes(selectedTag!))
      : posts
  );

  function toggleTag(tag: string) {
    selectedTag = selectedTag === tag ? null : tag;
  }
</script>

{#if tags.length > 0}
  <div class="flex items-center gap-4 mb-8 p-4 px-5 bg-paper-surface border border-paper-border">
    <span class="flex items-center gap-1.5 font-body text-[0.8rem] font-semibold uppercase tracking-[0.05em] text-paper-muted shrink-0">
      <svg class="w-3.5 h-3.5" fill="none" stroke="currentColor" viewBox="0 0 24 24" stroke-width="2">
        <path stroke-linecap="round" stroke-linejoin="round" d="M3 4a1 1 0 011-1h16a1 1 0 011 1v2.586a1 1 0 01-.293.707l-6.414 6.414a1 1 0 00-.293.707V17l-4 4v-6.586a1 1 0 00-.293-.707L3.293 7.293A1 1 0 013 6.586V4z"/>
      </svg>
      Filter
    </span>
    <div class="flex flex-wrap gap-1.5">
      <button
        class={`inline-flex items-center gap-1.5 px-3.5 py-1.5 font-body text-[0.8rem] font-medium border cursor-pointer transition-all duration-200 ease-in-out hover:border-paper-accent hover:text-paper-accent ${selectedTag === null ? 'bg-paper-accent text-white border-paper-accent' : 'border-paper-border bg-paper-bg text-paper-muted'}`}
        onclick={() => selectedTag = null}
      >
        All
        <span class={`text-[0.7rem] font-semibold ${selectedTag === null ? 'opacity-90' : 'opacity-70'}`}>{posts.length}</span>
      </button>
      {#each tags as tag}
        <button
          class={`inline-flex items-center gap-1.5 px-3.5 py-1.5 font-body text-[0.8rem] font-medium border cursor-pointer transition-all duration-200 ease-in-out hover:border-paper-accent hover:text-paper-accent ${selectedTag === tag ? 'bg-paper-accent text-white border-paper-accent' : 'border-paper-border bg-paper-bg text-paper-muted'}`}
          onclick={() => toggleTag(tag)}
        >
          {tag}
          <span class={`text-[0.7rem] font-semibold ${selectedTag === tag ? 'opacity-90' : 'opacity-70'}`}>{posts.filter(p => p.tags.includes(tag)).length}</span>
        </button>
      {/each}
    </div>
  </div>
{/if}

<div class="flex flex-col gap-4">
  {#each filteredPosts as post, i (post.href)}
    <a
      href={post.href}
      class="group block no-underline text-inherit animate-[slideUp_0.4s_ease_both]"
      target={post.external ? '_blank' : undefined}
      rel={post.external ? 'noopener noreferrer' : undefined}
      style="animation-delay: {i * 60}ms"
    >
      <article class="relative border border-paper-border px-8 py-7 bg-paper-bg overflow-hidden transition-all duration-300 ease-[cubic-bezier(0.4,0,0.2,1)] group-hover:border-paper-accent group-hover:shadow-[0_4px_12px_rgba(139,69,19,0.06)] group-hover:-translate-y-px">
        <div class="flex flex-wrap items-center gap-2 mb-3">
          {#each post.tags as tag}
            <span class="py-[0.2rem] px-2.5 font-body text-[0.7rem] font-semibold uppercase tracking-[0.04em] bg-paper-surface text-paper-accent border border-paper-border">{tag}</span>
          {/each}
          {#if post.readingTime}
            <span class="text-paper-border text-xs">&middot;</span>
            <span class="font-body text-[0.8rem] text-paper-muted">{post.readingTime}</span>
          {/if}
        </div>

        <h3 class="font-display text-xl font-bold text-paper-ink mb-2 leading-[1.4] transition-colors duration-200 group-hover:text-paper-accent">
          {post.title}
          {#if post.external}
            <svg class="inline-block w-3 h-3 ml-1 opacity-40" fill="none" stroke="currentColor" viewBox="0 0 24 24" stroke-width="2">
              <path stroke-linecap="round" stroke-linejoin="round" d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14"/>
            </svg>
          {/if}
        </h3>

        <p class="font-body text-[0.95rem] text-paper-muted leading-[1.7] mb-4">{post.description}</p>

        <div class="flex items-center justify-between">
          <time class="font-body text-[0.85rem] text-paper-muted">{post.pubDate}</time>
          <span class="flex items-center gap-1.5 font-body text-[0.85rem] font-semibold text-paper-accent opacity-0 -translate-x-2 transition-all duration-300 ease-in-out group-hover:opacity-100 group-hover:translate-x-0">
            {post.external ? 'Read on Medium' : 'Read more'}
            <svg class="w-3.5 h-3.5 transition-transform duration-200 group-hover:translate-x-0.5" fill="none" stroke="currentColor" viewBox="0 0 24 24" stroke-width="2">
              <path stroke-linecap="round" stroke-linejoin="round" d="M17 8l4 4m0 0l-4 4m4-4H3"/>
            </svg>
          </span>
        </div>

        <div class="absolute bottom-0 left-0 right-0 h-0.5 bg-paper-accent scale-x-0 origin-left transition-transform duration-300 ease-in-out group-hover:scale-x-100"></div>
      </article>
    </a>
  {/each}
</div>

{#if filteredPosts.length === 0}
  <div class="text-center p-12 text-paper-muted font-body text-[0.95rem]">
    <svg class="w-12 h-12 mx-auto mb-3 opacity-20" fill="none" stroke="currentColor" viewBox="0 0 24 24" stroke-width="1">
      <path stroke-linecap="round" stroke-linejoin="round" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
    </svg>
    <p>No posts match "<strong>{selectedTag}</strong>"</p>
    <button class="mt-3 px-5 py-2 border border-paper-border bg-paper-bg text-paper-accent font-body text-[0.85rem] font-medium cursor-pointer transition-all duration-200 ease-in-out hover:bg-paper-surface hover:border-paper-accent" onclick={() => selectedTag = null}>Clear filter</button>
  </div>
{/if}
