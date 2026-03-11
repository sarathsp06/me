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
    border-radius: 9999px;
    font-size: 0.65rem;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 0.05em;
    background: linear-gradient(135deg, #eff6ff, #e0e7ff);
    color: #3b82f6;
    border: 1px solid #bfdbfe;
    cursor: pointer;
    transition: all 0.2s ease;
  }
  .tag-pill:hover {
    background: linear-gradient(135deg, #dbeafe, #c7d2fe);
    transform: translateY(-1px);
    box-shadow: 0 2px 8px rgba(59, 130, 246, 0.15);
  }
  .tag-pill.active {
    background: linear-gradient(135deg, #3b82f6, #6366f1);
    color: white;
    border-color: #3b82f6;
    box-shadow: 0 2px 12px rgba(59, 130, 246, 0.3);
  }
  .reading-time {
    display: inline-flex;
    align-items: center;
    font-size: 0.75rem;
    color: #9ca3af;
  }
</style>
