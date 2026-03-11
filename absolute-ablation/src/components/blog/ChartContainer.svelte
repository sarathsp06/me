<script lang="ts">
  interface Props {
    id: string;
    chartConfig: any;
    /**
     * Format string for Y-axis (or radial axis) tick labels.
     * Use {v} for the raw value. Examples:
     *   "{v} pts"     →  "30 pts"
     *   "CHF {v}"     →  "CHF 1330"
     *   "${v}K"       →  "$5K" (when combined with yDivide)
     */
    yTickFormat?: string;
    /** Divide Y-axis tick values by this number before formatting (e.g. 1000 for "$5K") */
    yDivide?: number;
    /**
     * Format string for tooltip labels.
     * Use {l} for dataset/segment label, {v} for the parsed value.
     * Examples:
     *   "{l}: {v} pts"    →  "Feature work: 120 pts"
     *   "{v} CHF/day"     →  "65 CHF/day"
     *   "Score: {v}"      →  "Score: 14.2"
     */
    tooltipFormat?: string;
    /** If true, format tooltip value with toLocaleString() */
    tooltipLocale?: boolean;
    /** Fixed decimal places for tooltip value (e.g. 1 → "14.2") */
    tooltipFixed?: number;
  }

  let { id, chartConfig, yTickFormat, yDivide, tooltipFormat, tooltipLocale, tooltipFixed }: Props = $props();
  let canvas: HTMLCanvasElement;
  let chartInstance: any = $state(null);

  const CHART_JS_URL = 'https://cdn.jsdelivr.net/npm/chart.js';

  function loadChartJs(): Promise<void> {
    if ((window as any).__chartJsLoading) {
      return (window as any).__chartJsLoading;
    }
    if ((window as any).Chart) {
      return Promise.resolve();
    }
    (window as any).__chartJsLoading = new Promise<void>((resolve, reject) => {
      const script = document.createElement('script');
      script.src = CHART_JS_URL;
      script.onload = () => resolve();
      script.onerror = () => reject(new Error('Failed to load Chart.js'));
      document.head.appendChild(script);
    });
    return (window as any).__chartJsLoading;
  }

  /**
   * Recursively remove null values for keys that should be functions.
   * Astro serializes JS functions as null when passing through island props.
   */
  function cleanConfig(obj: any): any {
    if (obj === null || obj === undefined) return obj;
    if (typeof obj !== 'object') return obj;
    if (Array.isArray(obj)) return obj.map(cleanConfig);

    const cleaned: any = {};
    for (const [key, value] of Object.entries(obj)) {
      if (value === null && ['callback', 'label', 'title', 'footer', 'filter', 'sort', 'beforeBody', 'afterBody'].includes(key)) {
        continue;
      }
      cleaned[key] = cleanConfig(value);
    }
    return cleaned;
  }

  /**
   * Inject formatting callbacks based on the format prop strings.
   */
  function applyFormatting(config: any): any {
    if (!config.options) config.options = {};

    if (yTickFormat) {
      const fmt = yTickFormat;
      const divisor = yDivide || 1;
      if (!config.options.scales) config.options.scales = {};
      // Handle both 'y' axis and 'r' (radial) axis
      const axisKey = config.type === 'radar' ? 'r' : 'y';
      if (!config.options.scales[axisKey]) config.options.scales[axisKey] = {};
      if (!config.options.scales[axisKey].ticks) config.options.scales[axisKey].ticks = {};
      config.options.scales[axisKey].ticks.callback = function(v: number) {
        const val = divisor !== 1 ? v / divisor : v;
        return fmt.replace('{v}', String(val));
      };
    }

    if (tooltipFormat) {
      const fmt = tooltipFormat;
      const useLocale = tooltipLocale ?? false;
      const fixedDigits = tooltipFixed;
      if (!config.options.plugins) config.options.plugins = {};
      if (!config.options.plugins.tooltip) config.options.plugins.tooltip = {};
      if (!config.options.plugins.tooltip.callbacks) config.options.plugins.tooltip.callbacks = {};
      config.options.plugins.tooltip.callbacks.label = function(ctx: any) {
        let value = ctx.parsed?.y ?? ctx.parsed?.x ?? ctx.parsed;
        const label = ctx.dataset?.label || ctx.label || '';
        if (typeof value === 'number') {
          if (fixedDigits !== undefined) {
            value = value.toFixed(fixedDigits);
          } else if (useLocale) {
            value = value.toLocaleString();
          }
        }
        return fmt.replace('{l}', label).replace('{v}', String(value));
      };
    }

    return config;
  }

  $effect(() => {
    if (!canvas) return;

    let destroyed = false;

    loadChartJs().then(() => {
      if (destroyed) return;

      if (chartInstance) {
        chartInstance.destroy();
      }

      try {
        let config = JSON.parse(JSON.stringify(chartConfig));
        config = cleanConfig(config);
        config = applyFormatting(config);
        chartInstance = new (window as any).Chart(canvas, config);
      } catch (e) {
        console.error(`[ChartContainer] Failed to create chart "${id}":`, e);
      }
    }).catch((e) => {
      console.error('[ChartContainer] Failed to load Chart.js:', e);
    });

    return () => {
      destroyed = true;
      if (chartInstance) {
        chartInstance.destroy();
        chartInstance = null;
      }
    };
  });
</script>

<div class="chart-container" {id}>
  <canvas bind:this={canvas}></canvas>
</div>

<style>
  .chart-container {
    position: relative;
    width: 100%;
    max-width: 580px;
    height: 280px;
    margin: 1.5rem auto;
  }

  .chart-container canvas {
    width: 100% !important;
    height: 100% !important;
  }
</style>
