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
  <div class="filter-bar">
    <span class="filter-label">
      <svg class="w-3.5 h-3.5" fill="none" stroke="currentColor" viewBox="0 0 24 24" stroke-width="2">
        <path stroke-linecap="round" stroke-linejoin="round" d="M3 4a1 1 0 011-1h16a1 1 0 011 1v2.586a1 1 0 01-.293.707l-6.414 6.414a1 1 0 00-.293.707V17l-4 4v-6.586a1 1 0 00-.293-.707L3.293 7.293A1 1 0 013 6.586V4z"/>
      </svg>
      Filter
    </span>
    <div class="filter-tags">
      <button
        class="filter-tag"
        class:active={selectedTag === null}
        onclick={() => selectedTag = null}
      >
        All
        <span class="tag-count">{posts.length}</span>
      </button>
      {#each tags as tag}
        <button
          class="filter-tag"
          class:active={selectedTag === tag}
          onclick={() => toggleTag(tag)}
        >
          {tag}
          <span class="tag-count">{posts.filter(p => p.tags.includes(tag)).length}</span>
        </button>
      {/each}
    </div>
  </div>
{/if}

<div class="posts-grid">
  {#each filteredPosts as post, i (post.href)}
    <a
      href={post.href}
      class="post-card"
      target={post.external ? '_blank' : undefined}
      rel={post.external ? 'noopener noreferrer' : undefined}
      style="animation-delay: {i * 60}ms"
    >
      <article>
        <div class="card-meta">
          {#each post.tags as tag}
            <span class="tag">{tag}</span>
          {/each}
          {#if post.readingTime}
            <span class="dot">·</span>
            <span class="time">{post.readingTime}</span>
          {/if}
        </div>

        <h3 class="card-title">
          {post.title}
          {#if post.external}
            <svg class="inline-block w-3 h-3 ml-1 opacity-40" fill="none" stroke="currentColor" viewBox="0 0 24 24" stroke-width="2">
              <path stroke-linecap="round" stroke-linejoin="round" d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14"/>
            </svg>
          {/if}
        </h3>

        <p class="card-desc">{post.description}</p>

        <div class="card-bottom">
          <time>{post.pubDate}</time>
          <span class="read-link">
            {post.external ? 'Read on Medium' : 'Read more'}
            <svg class="w-3.5 h-3.5 arrow" fill="none" stroke="currentColor" viewBox="0 0 24 24" stroke-width="2">
              <path stroke-linecap="round" stroke-linejoin="round" d="M17 8l4 4m0 0l-4 4m4-4H3"/>
            </svg>
          </span>
        </div>

        <div class="accent-bar"></div>
      </article>
    </a>
  {/each}
</div>

{#if filteredPosts.length === 0}
  <div class="empty-state">
    <svg class="w-12 h-12 mx-auto mb-3 opacity-20" fill="none" stroke="currentColor" viewBox="0 0 24 24" stroke-width="1">
      <path stroke-linecap="round" stroke-linejoin="round" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
    </svg>
    <p>No posts match "<strong>{selectedTag}</strong>"</p>
    <button class="clear-btn" onclick={() => selectedTag = null}>Clear filter</button>
  </div>
{/if}

<style>
  .filter-bar {
    display: flex;
    align-items: center;
    gap: 1rem;
    margin-bottom: 2rem;
    padding: 1rem 1.25rem;
    background: white;
    border: 1px solid #e5e7eb;
    border-radius: 12px;
  }
  .filter-label {
    display: flex;
    align-items: center;
    gap: 0.375rem;
    font-size: 0.75rem;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 0.05em;
    color: #9ca3af;
    flex-shrink: 0;
  }
  .filter-tags {
    display: flex;
    flex-wrap: wrap;
    gap: 0.375rem;
  }
  .filter-tag {
    display: inline-flex;
    align-items: center;
    gap: 0.375rem;
    padding: 0.375rem 0.875rem;
    border-radius: 9999px;
    font-size: 0.75rem;
    font-weight: 500;
    border: 1px solid #e5e7eb;
    background: #fafafa;
    color: #6b7280;
    cursor: pointer;
    transition: all 0.2s ease;
  }
  .filter-tag:hover {
    border-color: #93c5fd;
    color: #3b82f6;
    background: #eff6ff;
  }
  .filter-tag.active {
    background: linear-gradient(135deg, #3b82f6, #6366f1);
    color: white;
    border-color: transparent;
    box-shadow: 0 2px 8px rgba(59, 130, 246, 0.25);
  }
  .tag-count {
    font-size: 0.65rem;
    opacity: 0.7;
    font-weight: 600;
  }
  .filter-tag.active .tag-count {
    opacity: 0.9;
  }

  .posts-grid {
    display: flex;
    flex-direction: column;
    gap: 1rem;
  }
  .post-card {
    display: block;
    text-decoration: none;
    color: inherit;
    animation: slideUp 0.4s ease both;
  }
  @keyframes slideUp {
    from { opacity: 0; transform: translateY(12px); }
    to { opacity: 1; transform: translateY(0); }
  }
  .post-card article {
    position: relative;
    border: 1px solid #e5e7eb;
    border-radius: 16px;
    padding: 1.75rem 2rem;
    background: white;
    overflow: hidden;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  }
  .post-card:hover article {
    border-color: #93c5fd;
    box-shadow: 0 4px 6px -1px rgba(59, 130, 246, 0.06), 0 10px 20px -5px rgba(59, 130, 246, 0.1);
    transform: translateY(-2px);
  }
  .accent-bar {
    position: absolute;
    bottom: 0;
    left: 0;
    right: 0;
    height: 3px;
    background: linear-gradient(90deg, #3b82f6, #8b5cf6, #ec4899);
    transform: scaleX(0);
    transform-origin: left;
    transition: transform 0.3s ease;
  }
  .post-card:hover .accent-bar {
    transform: scaleX(1);
  }
  .card-meta {
    display: flex;
    flex-wrap: wrap;
    align-items: center;
    gap: 0.5rem;
    margin-bottom: 0.75rem;
  }
  .tag {
    padding: 0.2rem 0.625rem;
    border-radius: 9999px;
    font-size: 0.65rem;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 0.04em;
    background: linear-gradient(135deg, #eff6ff, #e0e7ff);
    color: #3b82f6;
  }
  .dot {
    color: #d1d5db;
    font-size: 0.75rem;
  }
  .time {
    font-size: 0.75rem;
    color: #9ca3af;
  }
  .card-title {
    font-size: 1.25rem;
    font-weight: 700;
    color: #111827;
    margin-bottom: 0.5rem;
    line-height: 1.4;
    transition: color 0.2s;
  }
  .post-card:hover .card-title {
    color: #2563eb;
  }
  .card-desc {
    font-size: 0.9rem;
    color: #6b7280;
    line-height: 1.7;
    margin-bottom: 1rem;
  }
  .card-bottom {
    display: flex;
    align-items: center;
    justify-content: space-between;
  }
  .card-bottom time {
    font-size: 0.8rem;
    color: #9ca3af;
  }
  .read-link {
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
  .post-card:hover .read-link {
    opacity: 1;
    transform: translateX(0);
  }
  .arrow {
    transition: transform 0.2s;
  }
  .post-card:hover .arrow {
    transform: translateX(2px);
  }

  .empty-state {
    text-align: center;
    padding: 3rem;
    color: #9ca3af;
    font-size: 0.9rem;
  }
  .clear-btn {
    margin-top: 0.75rem;
    padding: 0.5rem 1.25rem;
    border-radius: 8px;
    border: 1px solid #e5e7eb;
    background: white;
    color: #3b82f6;
    font-size: 0.8rem;
    font-weight: 500;
    cursor: pointer;
    transition: all 0.2s ease;
  }
  .clear-btn:hover {
    background: #eff6ff;
    border-color: #93c5fd;
  }
</style>
