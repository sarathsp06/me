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
    padding: 0.3rem 0.875rem;
    border-radius: 9999px;
    font-size: 0.65rem;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 0.06em;
    background: linear-gradient(135deg, #eff6ff, #e0e7ff);
    color: #3b82f6;
    border: 1px solid #bfdbfe;
  }
  .header-time {
    display: inline-flex;
    align-items: center;
    font-size: 0.8rem;
    color: #9ca3af;
  }
  .article-title {
    font-size: 2rem;
    font-weight: 800;
    color: #111827;
    line-height: 1.2;
    margin-bottom: 1rem;
    letter-spacing: -0.02em;
  }
  @media (min-width: 768px) {
    .article-title {
      font-size: 2.5rem;
    }
  }
  .article-desc {
    font-size: 1.125rem;
    color: #6b7280;
    line-height: 1.7;
    max-width: 36rem;
  }
  .header-bottom {
    margin-top: 1.5rem;
  }
  .article-date {
    display: inline-flex;
    align-items: center;
    font-size: 0.875rem;
    color: #9ca3af;
  }
  .header-divider {
    margin-top: 1.5rem;
    height: 1px;
    background: linear-gradient(90deg, #e5e7eb, transparent);
  }
</style>
