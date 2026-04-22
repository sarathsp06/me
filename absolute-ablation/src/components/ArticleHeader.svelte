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

<header class="article-header" class:visible>
  <div class="header-meta">
    {#each tags as tag}
      <span class="header-tag">{tag}</span>
    {/each}
    {#if readingTime}
      <span class="header-time">
        <svg class="inline-block w-3.5 h-3.5 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24" stroke-width="2">
          <circle cx="12" cy="12" r="10"/>
          <path d="M12 6v6l4 2" stroke-linecap="round"/>
        </svg>
        {readingTime}
      </span>
    {/if}
  </div>

  <h1 class="article-title">{title}</h1>
  <p class="article-desc">{description}</p>

  <div class="header-bottom">
    <time class="article-date">
      <svg class="inline-block w-3.5 h-3.5 mr-1.5 opacity-40" fill="none" stroke="currentColor" viewBox="0 0 24 24" stroke-width="2">
        <rect x="3" y="4" width="18" height="18" rx="2" ry="2"/>
        <line x1="16" y1="2" x2="16" y2="6"/>
        <line x1="8" y1="2" x2="8" y2="6"/>
        <line x1="3" y1="10" x2="21" y2="10"/>
      </svg>
      {pubDate}
    </time>
    <div class="header-divider"></div>
  </div>
</header>

<style>
  .article-header {
    margin-bottom: 3rem;
    padding-bottom: 2rem;
    opacity: 0;
    transform: translateY(16px);
    transition: all 0.6s cubic-bezier(0.4, 0, 0.2, 1);
  }
  .article-header.visible {
    opacity: 1;
    transform: translateY(0);
  }
  .header-meta {
    display: flex;
    flex-wrap: wrap;
    align-items: center;
    gap: 0.5rem;
    margin-bottom: 1.25rem;
  }
  .header-tag {
    display: inline-flex;
    padding: 0.25rem 0.75rem;
    font-family: 'Crimson Pro', Georgia, serif;
    font-size: 0.7rem;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 0.06em;
    background: var(--color-paper-surface);
    color: var(--color-paper-accent);
    border: 1px solid var(--color-paper-border);
  }
  .header-time {
    display: inline-flex;
    align-items: center;
    font-family: 'Crimson Pro', Georgia, serif;
    font-size: 0.85rem;
    color: var(--color-paper-muted);
  }
  .article-title {
    font-family: 'Playfair Display', Georgia, serif;
    font-size: 2rem;
    font-weight: 700;
    color: var(--color-paper-ink);
    line-height: 1.2;
    margin-bottom: 1rem;
    letter-spacing: -0.01em;
  }
  @media (min-width: 768px) {
    .article-title {
      font-size: 2.5rem;
    }
  }
  .article-desc {
    font-family: 'Crimson Pro', Georgia, serif;
    font-size: 1.15rem;
    font-style: italic;
    color: var(--color-paper-muted);
    line-height: 1.7;
    max-width: 36rem;
  }
  .header-bottom {
    margin-top: 1.5rem;
  }
  .article-date {
    display: inline-flex;
    align-items: center;
    font-family: 'Crimson Pro', Georgia, serif;
    font-size: 0.9rem;
    color: var(--color-paper-muted);
  }
  .header-divider {
    margin-top: 1.5rem;
    height: 1px;
    background: var(--color-paper-border);
  }
</style>
