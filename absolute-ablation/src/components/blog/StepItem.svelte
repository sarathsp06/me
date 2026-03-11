<script lang="ts">
  interface Props {
    number: number;
    title: string;
    children: import('svelte').Snippet;
  }

  let { number, title, children }: Props = $props();
</script>

<div class="step-card">
  <div class="step-number">{number}</div>
  <div class="step-content">
    <h3 class="step-title">{title}</h3>
    <div class="step-body">
      {@render children()}
    </div>
  </div>
</div>

<style>
  .step-card {
    position: relative;
    padding-left: 4rem;
    padding-bottom: 2rem;
    border-left: 2px solid #e5e7eb;
    margin-left: 0;
  }

  .step-card:last-child {
    border-left-color: transparent;
    padding-bottom: 0;
  }

  .step-number {
    position: absolute;
    left: -1rem;
    top: 0;
    width: 2rem;
    height: 2rem;
    border-radius: 50%;
    background: linear-gradient(135deg, #2563eb, #1d4ed8);
    color: white;
    font-weight: 700;
    font-size: 0.85rem;
    display: flex;
    align-items: center;
    justify-content: center;
    box-shadow: 0 2px 8px rgba(37, 99, 235, 0.3);
  }

  .step-content {
    padding-top: 0.1rem;
  }

  .step-title {
    font-size: 1.05rem;
    font-weight: 700;
    color: #0f172a;
    margin: 0 0 0.5rem;
  }

  .step-body {
    font-size: 0.925rem;
    line-height: 1.6;
    color: #475569;
  }
</style>
