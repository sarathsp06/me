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
  class="card-link"
  target={external ? '_blank' : undefined}
  rel={external ? 'noopener noreferrer' : undefined}
  onmouseenter={() => hovered = true}
  onmouseleave={() => hovered = false}
  style="animation-delay: {index * 80}ms"
>
  <article class="blog-card" class:hovered>
    <div class="card-content">
      <div class="card-meta">
        {#each tags as tag}
          <span class="tag">{tag}</span>
        {/each}
        {#if readingTime}
          <span class="meta-separator">·</span>
          <span class="reading-time">{readingTime}</span>
        {/if}
      </div>

      <h3 class="card-title">
        {title}
        {#if external}
          <svg class="inline-block w-3.5 h-3.5 ml-1 opacity-40" fill="none" stroke="currentColor" viewBox="0 0 24 24" stroke-width="2">
            <path stroke-linecap="round" stroke-linejoin="round" d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14"/>
          </svg>
        {/if}
      </h3>

      <p class="card-description">{description}</p>

      <div class="card-footer">
        <time class="card-date">{pubDate}</time>
        <span class="read-more">
          {external ? 'Read on Medium' : 'Read more'}
          <svg class="arrow" fill="none" stroke="currentColor" viewBox="0 0 24 24" stroke-width="2">
            <path stroke-linecap="round" stroke-linejoin="round" d="M17 8l4 4m0 0l-4 4m4-4H3"/>
          </svg>
        </span>
      </div>
    </div>

    <div class="card-accent"></div>
  </article>
</a>

<style>
  .card-link {
    display: block;
    text-decoration: none;
    color: inherit;
    animation: slideUp 0.5s ease both;
  }
  @keyframes slideUp {
    from {
      opacity: 0;
      transform: translateY(16px);
    }
    to {
      opacity: 1;
      transform: translateY(0);
    }
  }
  .blog-card {
    position: relative;
    border: 1px solid #e5e7eb;
    border-radius: 16px;
    padding: 1.75rem 2rem;
    background: white;
    overflow: hidden;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  }
  .blog-card.hovered {
    border-color: #93c5fd;
    box-shadow:
      0 4px 6px -1px rgba(59, 130, 246, 0.06),
      0 10px 20px -5px rgba(59, 130, 246, 0.1);
    transform: translateY(-2px);
  }
  .card-accent {
    position: absolute;
    bottom: 0;
    left: 0;
    right: 0;
    height: 3px;
    background: linear-gradient(90deg, #3b82f6, #8b5cf6, #ec4899);
    transform: scaleX(0);
    transform-origin: left;
    transition: transform 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  }
  .blog-card.hovered .card-accent {
    transform: scaleX(1);
  }
  .card-meta {
    display: flex;
    flex-wrap: wrap;
    align-items: center;
    gap: 0.5rem;
    margin-bottom: 0.875rem;
  }
  .tag {
    display: inline-flex;
    padding: 0.2rem 0.625rem;
    border-radius: 9999px;
    font-size: 0.65rem;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 0.04em;
    background: linear-gradient(135deg, #eff6ff, #e0e7ff);
    color: #3b82f6;
  }
  .meta-separator {
    color: #d1d5db;
    font-size: 0.75rem;
  }
  .reading-time {
    font-size: 0.75rem;
    color: #9ca3af;
  }
  .card-title {
    font-size: 1.25rem;
    font-weight: 700;
    color: #111827;
    margin-bottom: 0.625rem;
    line-height: 1.4;
    transition: color 0.2s ease;
  }
  .blog-card.hovered .card-title {
    color: #2563eb;
  }
  .card-description {
    font-size: 0.9rem;
    color: #6b7280;
    line-height: 1.7;
    margin-bottom: 1rem;
  }
  .card-footer {
    display: flex;
    align-items: center;
    justify-content: space-between;
  }
  .card-date {
    font-size: 0.8rem;
    color: #9ca3af;
  }
  .read-more {
    display: flex;
    align-items: center;
    gap: 0.375rem;
    font-size: 0.8rem;
    font-weight: 600;
    color: #3b82f6;
    opacity: 0;
    transform: translateX(-8px);
    transition: all 0.3s ease;
  }
  .blog-card.hovered .read-more {
    opacity: 1;
    transform: translateX(0);
  }
  .arrow {
    width: 1rem;
    height: 1rem;
    transition: transform 0.2s ease;
  }
  .blog-card.hovered .arrow {
    transform: translateX(2px);
  }
</style>
