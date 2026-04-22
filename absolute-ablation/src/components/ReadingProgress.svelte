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

<div class="progress-container" class:visible>
  <div class="progress-bar" style="width: {progress}%"></div>
</div>

<style>
  .progress-container {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    height: 2px;
    z-index: 100;
    opacity: 0;
    transition: opacity 0.3s ease;
    background: var(--color-paper-border);
  }
  .progress-container.visible {
    opacity: 1;
  }
  .progress-bar {
    height: 100%;
    background: var(--color-paper-accent);
    transition: width 0.1s ease-out;
  }
</style>
