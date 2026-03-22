<script lang="ts">
  interface Props {
    children: import('svelte').Snippet;
  }

  let { children }: Props = $props();
</script>

<div class="step-list">
  {@render children()}
</div>

<style>
  .step-list {
    margin-left: 1.25rem;
    position: relative;
  }
</style>
