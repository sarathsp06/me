<script lang="ts">
  interface Props {
    tags?: string[];
    readingTime?: string;
  }

  let { tags = [], readingTime = '' }: Props = $props();

  let selectedTag: string | null = $state(null);

  function selectTag(tag: string) {
    selectedTag = selectedTag === tag ? null : tag;
  }
</script>

<div class="flex flex-wrap items-center gap-2">
  {#each tags as tag}
    <button
      onclick={() => selectTag(tag)}
      class="tag-pill"
      class:active={selectedTag === tag}
    >
      {tag}
    </button>
  {/each}
  {#if readingTime}
    <span class="reading-time">
      <svg class="inline-block w-3.5 h-3.5 mr-1 opacity-50" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <circle cx="12" cy="12" r="10" stroke-width="2"/>
        <path d="M12 6v6l4 2" stroke-width="2" stroke-linecap="round"/>
      </svg>
      {readingTime}
    </span>
  {/if}
</div>

<style>
  .tag-pill {
    display: inline-flex;
    align-items: center;
    padding: 0.25rem 0.75rem;
    font-family: 'Crimson Pro', Georgia, serif;
    font-size: 0.7rem;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 0.05em;
    background: var(--color-paper-surface);
    color: var(--color-paper-accent);
    border: 1px solid var(--color-paper-border);
    cursor: pointer;
    transition: all 0.2s ease;
  }
  .tag-pill:hover {
    border-color: var(--color-paper-accent);
    transform: translateY(-1px);
  }
  .tag-pill.active {
    background: var(--color-paper-accent);
    color: white;
    border-color: var(--color-paper-accent);
  }
  .reading-time {
    display: inline-flex;
    align-items: center;
    font-family: 'Crimson Pro', Georgia, serif;
    font-size: 0.8rem;
    color: var(--color-paper-muted);
  }
</style>
