<script lang="ts">
  interface Props {
    number: number;
    title: string;
    children: import('svelte').Snippet;
  }

  let { number, title, children }: Props = $props();
</script>

<div class="relative pl-16 pb-8 border-l-2 border-gray-200 ml-0 last:border-l-transparent last:pb-0">
  <div class="absolute -left-4 top-0 w-8 h-8 rounded-full bg-gradient-to-br from-blue-600 to-blue-700 text-white font-bold text-[0.85rem] flex items-center justify-center shadow-[0_2px_8px_rgba(37,99,235,0.3)]">
    {number}
  </div>
  <div class="pt-[0.1rem]">
    <h3 class="text-[1.05rem] font-bold text-slate-900 m-0 mb-2">{title}</h3>
    <div class="text-[0.925rem] leading-relaxed text-slate-500">
      {@render children()}
    </div>
  </div>
</div>
