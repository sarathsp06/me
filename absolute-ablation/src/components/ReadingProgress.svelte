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
  <div class="progress-glow" style="left: {progress}%"></div>
</div>

<style>
  .progress-container {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    height: 3px;
    z-index: 100;
    opacity: 0;
    transition: opacity 0.3s ease;
    background: rgba(0, 0, 0, 0.05);
  }
  .progress-container.visible {
    opacity: 1;
  }
  .progress-bar {
    height: 100%;
    background: linear-gradient(90deg, #3b82f6, #8b5cf6, #ec4899);
    transition: width 0.1s ease-out;
    border-radius: 0 2px 2px 0;
  }
  .progress-glow {
    position: absolute;
    top: 0;
    width: 80px;
    height: 100%;
    background: linear-gradient(90deg, transparent, rgba(139, 92, 246, 0.5), transparent);
    transform: translateX(-50%);
    filter: blur(3px);
  }
</style>
