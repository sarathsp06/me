<script lang="ts">
  interface Props {
    accent: 'blue' | 'amber' | 'emerald';
    icon: string;
    title: string;
    children: import('svelte').Snippet;
  }

  let { accent, icon, title, children }: Props = $props();

  const accentColors: Record<string, { border: string; bg: string; text: string }> = {
    blue: { border: '#2563eb', bg: '#dbeafe', text: '#2563eb' },
    amber: { border: '#d97706', bg: '#fef3c7', text: '#d97706' },
    emerald: { border: '#059669', bg: '#d1fae5', text: '#059669' },
  };

  let colors = $derived(accentColors[accent]);
</script>

<div class="example-card" style="border-left-color: {colors.border};">
  <div class="example-header">
    <span class="example-icon" style="background-color: {colors.bg}; color: {colors.text};">
      <i class="fas {icon}"></i>
    </span>
    <h3 class="example-title">{title}</h3>
  </div>
  <div class="example-body">
    {@render children()}
  </div>
</div>

<style>
  .example-card {
    background: white;
    border: 1px solid #e5e7eb;
    border-left: 4px solid;
    border-radius: 0.75rem;
    padding: 1.5rem;
    margin: 1rem 0;
    transition: transform 0.2s ease, box-shadow 0.2s ease;
  }

  .example-card:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 25px rgba(0, 0, 0, 0.08);
  }

  .example-header {
    display: flex;
    align-items: center;
    gap: 0.75rem;
    margin-bottom: 0.75rem;
  }

  .example-icon {
    width: 2rem;
    height: 2rem;
    border-radius: 0.5rem;
    display: flex;
    align-items: center;
    justify-content: center;
    flex-shrink: 0;
    font-size: 0.8rem;
  }

  .example-title {
    font-size: 1.05rem;
    font-weight: 700;
    color: #0f172a;
    margin: 0;
  }

  .example-body {
    font-size: 0.925rem;
    line-height: 1.6;
    color: #475569;
  }
</style>
