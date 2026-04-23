<script lang="ts">
  interface Props {
    href: string;
    icon?: string;
    children: import('svelte').Snippet;
  }

  let { href, icon = 'fa-arrow-right', children }: Props = $props();
</script>

<a class="group flex items-center gap-3 bg-white border border-gray-200 rounded-lg px-5 py-4 my-2 no-underline text-slate-700 transition-all duration-200 ease-in-out hover:border-blue-600 hover:bg-blue-50 hover:shadow-[0_4px_12px_rgba(37,99,235,0.1)]" {href} target="_blank" rel="noopener noreferrer">
  <span class="w-8 h-8 rounded-lg bg-slate-100 text-slate-500 flex items-center justify-center shrink-0 text-[0.8rem] transition-all duration-200 ease-in-out group-hover:bg-blue-100 group-hover:text-blue-600">
    <i class="fas {icon}"></i>
  </span>
  <span class="flex-1 text-[0.925rem] font-medium leading-[1.4]">
    {@render children()}
  </span>
  <span class="text-slate-300 text-xs shrink-0 transition-all duration-200 ease-in-out group-hover:text-blue-600 group-hover:translate-x-0.5">
    <i class="fas fa-arrow-right"></i>
  </span>
</a>
