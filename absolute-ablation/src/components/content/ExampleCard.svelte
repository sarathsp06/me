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

<div class="bg-white border border-gray-200 border-l-4 rounded-xl p-6 my-4 transition-all duration-200 ease-in-out hover:-translate-y-0.5 hover:shadow-[0_8px_25px_rgba(0,0,0,0.08)]" style="border-left-color: {colors.border};">
  <div class="flex items-center gap-3 mb-3">
    <span class="w-8 h-8 rounded-lg flex items-center justify-center shrink-0 text-[0.8rem]" style="background-color: {colors.bg}; color: {colors.text};">
      <i class="fas {icon}"></i>
    </span>
    <h3 class="text-[1.05rem] font-bold text-slate-900 m-0">{title}</h3>
  </div>
  <div class="text-[0.925rem] leading-relaxed text-slate-500">
    {@render children()}
  </div>
</div>
