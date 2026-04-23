<script lang="ts">
  interface Props {
    label: string;
    value: string;
    percentage: number;
    color: string;
  }

  let { label, value, percentage, color }: Props = $props();

  const colorMap: Record<string, string> = {
    blue: '#60a5fa',
    amber: '#fbbf24',
    emerald: '#34d399',
    red: '#f87171',
    purple: '#a78bfa',
    indigo: '#818cf8',
  };

  let fillColor = $derived(colorMap[color] ?? color);
</script>

<div class="flex items-center gap-2">
  <span class="text-xs font-semibold text-slate-500 w-10 shrink-0 uppercase">{label}</span>
  <div class="flex-1 h-2 bg-slate-100 rounded overflow-hidden">
    <div
      class="h-full rounded transition-[width] duration-600 ease-in-out"
      style="width: {percentage}%; background-color: {fillColor};"
    ></div>
  </div>
  <span class="text-[0.8rem] font-semibold text-slate-700 w-10 text-right shrink-0">{value}</span>
</div>
