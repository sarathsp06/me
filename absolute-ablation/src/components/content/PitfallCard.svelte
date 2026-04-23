<script lang="ts">
  interface Props {
    title: string;
    children: import('svelte').Snippet;
  }

  let { title, children }: Props = $props();
</script>

<div class="bg-gradient-to-br from-red-50 to-white border border-red-100 rounded-xl px-6 py-5 my-4 transition-all duration-200 ease-in-out hover:-translate-y-0.5 hover:shadow-[0_8px_25px_rgba(239,68,68,0.08)]">
  <div class="flex items-center gap-2.5 mb-2">
    <span class="w-7 h-7 rounded-full bg-red-200 text-red-600 flex items-center justify-center shrink-0 text-xs font-bold">
      <i class="fas fa-xmark"></i>
    </span>
    <h3 class="text-base font-bold text-red-900 m-0">{title}</h3>
  </div>
  <div class="text-[0.925rem] leading-relaxed text-slate-500 pl-[2.4rem]">
    {@render children()}
  </div>
</div>
