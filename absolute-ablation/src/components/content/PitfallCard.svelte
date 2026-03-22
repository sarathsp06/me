<script lang="ts">
  interface Props {
    title: string;
    children: import('svelte').Snippet;
  }

  let { title, children }: Props = $props();
</script>

<div class="pitfall-card">
  <div class="pitfall-header">
    <span class="pitfall-icon">
      <i class="fas fa-xmark"></i>
    </span>
    <h3 class="pitfall-title">{title}</h3>
  </div>
  <div class="pitfall-body">
    {@render children()}
  </div>
</div>

<style>
  .pitfall-card {
    background: linear-gradient(135deg, #fff5f5, white);
    border: 1px solid #fee2e2;
    border-radius: 0.75rem;
    padding: 1.25rem 1.5rem;
    margin: 1rem 0;
    transition: transform 0.2s ease, box-shadow 0.2s ease;
  }

  .pitfall-card:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 25px rgba(239, 68, 68, 0.08);
  }

  .pitfall-header {
    display: flex;
    align-items: center;
    gap: 0.65rem;
    margin-bottom: 0.5rem;
  }

  .pitfall-icon {
    width: 1.75rem;
    height: 1.75rem;
    border-radius: 50%;
    background-color: #fecaca;
    color: #dc2626;
    display: flex;
    align-items: center;
    justify-content: center;
    flex-shrink: 0;
    font-size: 0.75rem;
    font-weight: 700;
  }

  .pitfall-title {
    font-size: 1rem;
    font-weight: 700;
    color: #991b1b;
    margin: 0;
  }

  .pitfall-body {
    font-size: 0.925rem;
    line-height: 1.6;
    color: #475569;
    padding-left: 2.4rem;
  }
</style>
