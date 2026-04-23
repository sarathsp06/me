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
      class={`inline-flex items-center px-3 py-1 font-body text-[0.7rem] font-semibold uppercase tracking-[0.05em] border cursor-pointer transition-all duration-200 ease-in-out hover:border-paper-accent hover:-translate-y-px ${selectedTag === tag ? 'bg-paper-accent text-white border-paper-accent' : 'bg-paper-surface text-paper-accent border-paper-border'}`}
    >
      {tag}
    </button>
  {/each}
  {#if readingTime}
    <span class="inline-flex items-center font-body text-[0.8rem] text-paper-muted">
      <svg class="inline-block w-3.5 h-3.5 mr-1 opacity-50" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <circle cx="12" cy="12" r="10" stroke-width="2"/>
        <path d="M12 6v6l4 2" stroke-width="2" stroke-linecap="round"/>
      </svg>
      {readingTime}
    </span>
  {/if}
</div>
