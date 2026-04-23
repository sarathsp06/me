<script lang="ts">
  interface Props {
    items: string[];
  }

  let { items }: Props = $props();
</script>

<div class="bg-gradient-to-br from-blue-50 to-indigo-50 border border-blue-200 rounded-xl p-6 my-6">
  <div class="flex items-center gap-2 text-[1.1rem] font-extrabold text-blue-800 mb-4 uppercase tracking-wide">
    <i class="fas fa-bolt text-blue-600 text-base"></i>
    <span>TL;DR</span>
  </div>
  <ul class="list-none p-0 m-0 flex flex-col gap-3">
    {#each items as item}
      <li class="flex items-start gap-[0.65rem] text-[0.95rem] leading-relaxed text-slate-800">
        <i class="fas fa-check-circle text-blue-600 mt-1 shrink-0 text-[0.85rem]"></i>
        <span>{@html item}</span>
      </li>
    {/each}
  </ul>
</div>
