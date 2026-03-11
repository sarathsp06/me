<script lang="ts">
  interface Props {
    label: string;
    value: string;
    percentage: number;
    color: string;
  }

  let { label, value, percentage, color }: Props = $props();

  const colorMap: Record<string, string> = {
    blue: '#60a5fa',
    amber: '#fbbf24',
    emerald: '#34d399',
    red: '#f87171',
    purple: '#a78bfa',
    indigo: '#818cf8',
  };

  let fillColor = $derived(colorMap[color] ?? color);
</script>

<div class="metric-bar-row">
  <span class="metric-label">{label}</span>
  <div class="metric-bar">
    <div
      class="metric-bar-fill"
      style="width: {percentage}%; background-color: {fillColor};"
    ></div>
  </div>
  <span class="metric-value">{value}</span>
</div>

<style>
  .metric-bar-row {
    display: flex;
    align-items: center;
    gap: 0.5rem;
  }

  .metric-label {
    font-size: 0.75rem;
    font-weight: 600;
    color: #64748b;
    width: 2.5rem;
    flex-shrink: 0;
    text-transform: uppercase;
  }

  .metric-bar {
    flex: 1;
    height: 8px;
    background-color: #f1f5f9;
    border-radius: 4px;
    overflow: hidden;
  }

  .metric-bar-fill {
    height: 100%;
    border-radius: 4px;
    transition: width 0.6s ease;
  }

  .metric-value {
    font-size: 0.8rem;
    font-weight: 600;
    color: #334155;
    width: 2.5rem;
    text-align: right;
    flex-shrink: 0;
  }
</style>
