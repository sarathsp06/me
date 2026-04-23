<script lang="ts">
  interface Props {
    caption?: string;
    children: import('svelte').Snippet;
  }

  let { caption, children }: Props = $props();
</script>

<div class="bg-gradient-to-br from-slate-800 to-slate-900 rounded-xl p-8 text-center my-8 relative overflow-hidden">
  <div class="absolute inset-0 bg-[radial-gradient(ellipse_at_center,rgba(59,130,246,0.1)_0%,transparent_70%)] pointer-events-none"></div>
  <div class="relative text-white font-mono text-[1.15rem] leading-[1.8] z-[1]">
    {@render children()}
  </div>
  {#if caption}
    <div class="relative text-slate-400 text-[0.85rem] mt-4 italic z-[1]">{caption}</div>
  {/if}
</div>
