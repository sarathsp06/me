<script lang="ts">
  let progress = $state(0);
  let visible = $state(false);

  $effect(() => {
    function updateProgress() {
      const scrollTop = window.scrollY;
      const docHeight = document.documentElement.scrollHeight - window.innerHeight;
      progress = docHeight > 0 ? (scrollTop / docHeight) * 100 : 0;
      visible = scrollTop > 100;
    }
    window.addEventListener('scroll', updateProgress, { passive: true });
    return () => window.removeEventListener('scroll', updateProgress);
  });
</script>

<div class="fixed top-0 left-0 right-0 h-0.5 z-100 transition-opacity duration-300 ease-in-out bg-paper-border {visible ? 'opacity-100' : 'opacity-0'}">
  <div class="h-full bg-paper-accent transition-[width] duration-100 ease-out" style="width: {progress}%"></div>
</div>
