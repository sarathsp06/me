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

<h2 class="flex items-center gap-3 text-2xl font-bold text-slate-900 mt-10 mb-4 leading-[1.3]">
  <span class="w-8 h-8 rounded-lg flex items-center justify-center shrink-0 text-[0.85rem]" style="background-color: {colors.bg}; color: {colors.text};">
    <i class="fas {icon}"></i>
  </span>
  <span class="flex-1">
    {@render children()}
  </span>
</h2>
