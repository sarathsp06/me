<script lang="ts">
  interface Props {
    type?: 'insight' | 'tip' | 'warning';
    title?: string;
    icon?: string;
    children: import('svelte').Snippet;
  }

  let { type = 'insight', title, icon, children }: Props = $props();

  const defaults = {
    insight: { title: 'Key Insight', icon: 'fa-lightbulb' },
    tip: { title: 'Tip', icon: 'fa-check' },
    warning: { title: 'Warning', icon: 'fa-triangle-exclamation' },
  };

  let resolvedTitle = $derived(title ?? defaults[type].title);
  let resolvedIcon = $derived(icon ?? defaults[type].icon);

  const bgClasses = { insight: 'bg-blue-50 border-blue-200', tip: 'bg-green-50 border-green-200', warning: 'bg-amber-50 border-amber-200' };
  const iconBgClasses = { insight: 'bg-blue-600', tip: 'bg-green-600', warning: 'bg-amber-600' };
  const titleClasses = { insight: 'text-blue-800', tip: 'text-green-800', warning: 'text-amber-800' };
</script>

<div class="rounded-lg px-6 py-5 my-6 flex gap-4 border {bgClasses[type]}">
  <div class="w-7 h-7 rounded-full flex items-center justify-center shrink-0 text-[0.8rem] text-white {iconBgClasses[type]}">
    <i class="fas {resolvedIcon}"></i>
  </div>
  <div class="flex-1 min-w-0">
    <div class="font-bold text-[0.95rem] mb-1 {titleClasses[type]}">{resolvedTitle}</div>
    <div class="text-[0.925rem] leading-relaxed">
      {@render children()}
    </div>
  </div>
</div>
