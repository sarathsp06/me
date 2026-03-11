<script lang="ts">
  interface Props {
    caption?: string;
    children: import('svelte').Snippet;
  }

  let { caption, children }: Props = $props();
</script>

<div class="formula-box">
  <div class="formula-overlay"></div>
  <div class="formula-content">
    {@render children()}
  </div>
  {#if caption}
    <div class="formula-caption">{caption}</div>
  {/if}
</div>

<style>
  .formula-box {
    background: linear-gradient(135deg, #1e293b, #0f172a);
    border-radius: 0.75rem;
    padding: 2rem;
    text-align: center;
    margin: 2rem 0;
    position: relative;
    overflow: hidden;
  }

  .formula-overlay {
    position: absolute;
    inset: 0;
    background: radial-gradient(ellipse at center, rgba(59, 130, 246, 0.1) 0%, transparent 70%);
    pointer-events: none;
  }

  .formula-content {
    position: relative;
    color: white;
    font-family: 'JetBrains Mono', 'Fira Code', 'Courier New', monospace;
    font-size: 1.15rem;
    line-height: 1.8;
    z-index: 1;
  }

  .formula-caption {
    position: relative;
    color: #94a3b8;
    font-size: 0.85rem;
    margin-top: 1rem;
    font-style: italic;
    z-index: 1;
  }
</style>
