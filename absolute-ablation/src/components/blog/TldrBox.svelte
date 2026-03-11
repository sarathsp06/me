<script lang="ts">
  interface Props {
    items: string[];
  }

  let { items }: Props = $props();
</script>

<div class="tldr-box">
  <div class="tldr-header">
    <i class="fas fa-bolt"></i>
    <span>TL;DR</span>
  </div>
  <ul class="tldr-list">
    {#each items as item}
      <li class="tldr-item">
        <i class="fas fa-check-circle tldr-check"></i>
        <span>{@html item}</span>
      </li>
    {/each}
  </ul>
</div>

<style>
  .tldr-box {
    background: linear-gradient(135deg, #eff6ff, #eef2ff);
    border: 1px solid #bfdbfe;
    border-radius: 0.75rem;
    padding: 1.5rem;
    margin: 1.5rem 0;
  }

  .tldr-header {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    font-size: 1.1rem;
    font-weight: 800;
    color: #1e40af;
    margin-bottom: 1rem;
    text-transform: uppercase;
    letter-spacing: 0.05em;
  }

  .tldr-header i {
    color: #2563eb;
    font-size: 1rem;
  }

  .tldr-list {
    list-style: none;
    padding: 0;
    margin: 0;
    display: flex;
    flex-direction: column;
    gap: 0.75rem;
  }

  .tldr-item {
    display: flex;
    align-items: flex-start;
    gap: 0.65rem;
    font-size: 0.95rem;
    line-height: 1.6;
    color: #1e293b;
  }

  .tldr-check {
    color: #2563eb;
    margin-top: 0.25rem;
    flex-shrink: 0;
    font-size: 0.85rem;
  }
</style>
