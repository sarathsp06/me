<script lang="ts">
  interface Metric {
    label: string;
    value: string;
    percentage: number;
    color: string;
  }

  interface Props {
    letter: string;
    title: string;
    description: string;
    metrics: Metric[];
    jobSize: string;
    wsjfScore: number;
    winner?: boolean;
  }

  let { letter, title, description, metrics, jobSize, wsjfScore, winner = false }: Props = $props();

  const colorMap: Record<string, string> = {
    blue: '#60a5fa',
    amber: '#fbbf24',
    emerald: '#34d399',
    red: '#f87171',
    purple: '#a78bfa',
    indigo: '#818cf8',
  };
</script>

<div class="bg-white border rounded-xl p-6 relative transition-all duration-200 ease-in-out hover:-translate-y-0.5 hover:shadow-[0_8px_25px_rgba(0,0,0,0.08)]" class:border-blue-600={winner} class:shadow-[0_4px_15px_rgba(37,99,235,0.15)]={winner} class:border-gray-200={!winner}>
  {#if winner}
    <div class="absolute -top-2.5 right-4 bg-gradient-to-br from-blue-600 to-blue-700 text-white text-[0.7rem] font-bold py-1 px-3 rounded-full uppercase tracking-wide">
      <i class="fas fa-trophy"></i> Winner
    </div>
  {/if}

  <div class="flex items-start gap-3 mb-5">
    <span class="w-10 h-10 rounded-lg flex items-center justify-center font-extrabold text-lg shrink-0" class:bg-blue-600={winner} class:text-white={winner} class:bg-gray-100={!winner} class:text-gray-500={!winner}>
      {letter}
    </span>
    <div class="flex-1 min-w-0">
      <h3 class="text-[1.05rem] font-bold text-slate-900 m-0 mb-1">{title}</h3>
      <p class="text-[0.85rem] text-slate-500 m-0 leading-snug">{description}</p>
    </div>
  </div>

  <div class="flex flex-col gap-2.5 mb-5">
    {#each metrics as metric}
      <div class="flex items-center gap-2">
        <span class="text-xs font-semibold text-slate-500 w-8 shrink-0 uppercase">{metric.label}</span>
        <div class="flex-1 h-2 bg-slate-100 rounded overflow-hidden">
          <div
            class="h-full rounded transition-[width] duration-[0.6s] ease-in-out"
            style="width: {metric.percentage}%; background-color: {colorMap[metric.color] ?? metric.color};"
          ></div>
        </div>
        <span class="text-[0.8rem] font-semibold text-slate-700 w-8 text-right shrink-0">{metric.value}</span>
      </div>
    {/each}
  </div>

  <div class="flex items-center justify-between pt-4 border-t border-slate-100">
    <div>
      <span class="text-[0.7rem] text-slate-400 uppercase tracking-wide block">Job Size</span>
      <span class="text-[0.9rem] font-semibold text-slate-700">{jobSize}</span>
    </div>
    <div class={`flex flex-col items-center px-3.5 py-1.5 rounded-lg ${winner ? 'bg-gradient-to-br from-blue-600 to-blue-700' : 'bg-slate-100'}`}>
      <span class={`text-[0.6rem] font-bold uppercase tracking-wide ${winner ? 'text-white/80' : 'text-slate-400'}`}>WSJF</span>
      <span class={`text-lg font-extrabold ${winner ? 'text-white' : 'text-slate-900'}`}>{wsjfScore}</span>
    </div>
  </div>
</div>
