<script lang="ts">
  interface Props {
    href: string;
    icon?: string;
    children: import('svelte').Snippet;
  }

  let { href, icon = 'fa-arrow-right', children }: Props = $props();
</script>

<a class="link-card" {href} target="_blank" rel="noopener noreferrer">
  <span class="link-card-icon">
    <i class="fas {icon}"></i>
  </span>
  <span class="link-card-content">
    {@render children()}
  </span>
  <span class="link-card-arrow">
    <i class="fas fa-arrow-right"></i>
  </span>
</a>

<style>
  .link-card {
    display: flex;
    align-items: center;
    gap: 0.75rem;
    background: white;
    border: 1px solid #e5e7eb;
    border-radius: 0.5rem;
    padding: 1rem 1.25rem;
    margin: 0.5rem 0;
    text-decoration: none;
    color: #334155;
    transition: all 0.2s ease;
  }

  .link-card:hover {
    border-color: #2563eb;
    background-color: #eff6ff;
    box-shadow: 0 4px 12px rgba(37, 99, 235, 0.1);
  }

  .link-card-icon {
    width: 2rem;
    height: 2rem;
    border-radius: 0.5rem;
    background-color: #f1f5f9;
    color: #64748b;
    display: flex;
    align-items: center;
    justify-content: center;
    flex-shrink: 0;
    font-size: 0.8rem;
    transition: all 0.2s ease;
  }

  .link-card:hover .link-card-icon {
    background-color: #dbeafe;
    color: #2563eb;
  }

  .link-card-content {
    flex: 1;
    font-size: 0.925rem;
    font-weight: 500;
    line-height: 1.4;
  }

  .link-card-arrow {
    color: #cbd5e1;
    font-size: 0.75rem;
    flex-shrink: 0;
    transition: all 0.2s ease;
  }

  .link-card:hover .link-card-arrow {
    color: #2563eb;
    transform: translateX(2px);
  }
</style>
