<script lang="ts">
  interface Props {
    icon: string;
    color: string;
    children: import('svelte').Snippet;
  }

  let { icon, color, children }: Props = $props();

  const colorMap: Record<string, { bg: string; text: string }> = {
    red: { bg: '#fee2e2', text: '#dc2626' },
    blue: { bg: '#dbeafe', text: '#2563eb' },
    amber: { bg: '#fef3c7', text: '#d97706' },
    purple: { bg: '#f3e8ff', text: '#9333ea' },
    indigo: { bg: '#e0e7ff', text: '#4f46e5' },
    emerald: { bg: '#d1fae5', text: '#059669' },
    gray: { bg: '#f3f4f6', text: '#4b5563' },
  };

  let colors = $derived(colorMap[color] ?? colorMap.blue);
</script>

<h2 class="section-heading">
  <span class="section-icon" style="background-color: {colors.bg}; color: {colors.text};">
    <i class="fas {icon}"></i>
  </span>
  <span class="section-text">
    {@render children()}
  </span>
</h2>

<style>
  .section-heading {
    display: flex;
    align-items: center;
    gap: 0.75rem;
    font-size: 1.5rem;
    font-weight: 700;
    color: #0f172a;
    margin: 2.5rem 0 1rem;
    line-height: 1.3;
  }

  .section-icon {
    width: 2rem;
    height: 2rem;
    border-radius: 0.5rem;
    display: flex;
    align-items: center;
    justify-content: center;
    flex-shrink: 0;
    font-size: 0.85rem;
  }

  .section-text {
    flex: 1;
  }
</style>
