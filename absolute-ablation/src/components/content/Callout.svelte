<script lang="ts">
  interface Props {
    type?: 'insight' | 'tip' | 'warning';
    title?: string;
    icon?: string;
    children: import('svelte').Snippet;
  }

  let { type = 'insight', title, icon, children }: Props = $props();

  const defaults = {
    insight: { title: 'Key Insight', icon: 'fa-lightbulb' },
    tip: { title: 'Tip', icon: 'fa-check' },
    warning: { title: 'Warning', icon: 'fa-triangle-exclamation' },
  };

  let resolvedTitle = $derived(title ?? defaults[type].title);
  let resolvedIcon = $derived(icon ?? defaults[type].icon);
</script>

<div class="callout callout-{type}">
  <div class="callout-icon">
    <i class="fas {resolvedIcon}"></i>
  </div>
  <div class="callout-content">
    <div class="callout-title">{resolvedTitle}</div>
    <div class="callout-body">
      {@render children()}
    </div>
  </div>
</div>

<style>
  .callout {
    border-radius: 0.5rem;
    padding: 1.25rem 1.5rem;
    margin: 1.5rem 0;
    display: flex;
    gap: 1rem;
    border: 1px solid;
  }

  .callout-icon {
    width: 28px;
    height: 28px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    flex-shrink: 0;
    font-size: 0.8rem;
  }

  .callout-content {
    flex: 1;
    min-width: 0;
  }

  .callout-title {
    font-weight: 700;
    font-size: 0.95rem;
    margin-bottom: 0.35rem;
  }

  .callout-body {
    font-size: 0.925rem;
    line-height: 1.6;
  }

  .callout-insight {
    background-color: #eff6ff;
    border-color: #bfdbfe;
  }

  .callout-insight .callout-icon {
    background-color: #2563eb;
    color: white;
  }

  .callout-insight .callout-title {
    color: #1e40af;
  }

  .callout-tip {
    background-color: #f0fdf4;
    border-color: #bbf7d0;
  }

  .callout-tip .callout-icon {
    background-color: #16a34a;
    color: white;
  }

  .callout-tip .callout-title {
    color: #166534;
  }

  .callout-warning {
    background-color: #fffbeb;
    border-color: #fde68a;
  }

  .callout-warning .callout-icon {
    background-color: #d97706;
    color: white;
  }

  .callout-warning .callout-title {
    color: #92400e;
  }
</style>
