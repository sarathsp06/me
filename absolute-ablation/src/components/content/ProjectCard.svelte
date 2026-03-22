<script lang="ts">
  interface Metric {
    label: string;
    value: string;
    percentage: number;
    color: string;
  }

  interface Props {
    letter: string;
    title: string;
    description: string;
    metrics: Metric[];
    jobSize: string;
    wsjfScore: number;
    winner?: boolean;
  }

  let { letter, title, description, metrics, jobSize, wsjfScore, winner = false }: Props = $props();

  const colorMap: Record<string, string> = {
    blue: '#60a5fa',
    amber: '#fbbf24',
    emerald: '#34d399',
    red: '#f87171',
    purple: '#a78bfa',
    indigo: '#818cf8',
  };
</script>

<div class="project-card" class:winner>
  {#if winner}
    <div class="winner-badge">
      <i class="fas fa-trophy"></i> Winner
    </div>
  {/if}

  <div class="card-header">
    <span class="letter-badge" class:letter-winner={winner}>
      {letter}
    </span>
    <div class="card-info">
      <h3 class="card-title">{title}</h3>
      <p class="card-description">{description}</p>
    </div>
  </div>

  <div class="metrics">
    {#each metrics as metric}
      <div class="metric-row">
        <span class="metric-label">{metric.label}</span>
        <div class="metric-bar">
          <div
            class="metric-bar-fill"
            style="width: {metric.percentage}%; background-color: {colorMap[metric.color] ?? metric.color};"
          ></div>
        </div>
        <span class="metric-value">{metric.value}</span>
      </div>
    {/each}
  </div>

  <div class="card-footer">
    <div class="job-size">
      <span class="footer-label">Job Size</span>
      <span class="footer-value">{jobSize}</span>
    </div>
    <div class="score-badge" class:score-winner={winner}>
      <span class="score-label">WSJF</span>
      <span class="score-value">{wsjfScore}</span>
    </div>
  </div>
</div>

<style>
  .project-card {
    background: white;
    border: 1px solid #e5e7eb;
    border-radius: 0.75rem;
    padding: 1.5rem;
    position: relative;
    transition: transform 0.2s ease, box-shadow 0.2s ease;
  }

  .project-card:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 25px rgba(0, 0, 0, 0.08);
  }

  .project-card.winner {
    border-color: #2563eb;
    box-shadow: 0 4px 15px rgba(37, 99, 235, 0.15);
  }

  .winner-badge {
    position: absolute;
    top: -0.65rem;
    right: 1rem;
    background: linear-gradient(135deg, #2563eb, #1d4ed8);
    color: white;
    font-size: 0.7rem;
    font-weight: 700;
    padding: 0.25rem 0.75rem;
    border-radius: 1rem;
    text-transform: uppercase;
    letter-spacing: 0.05em;
  }

  .card-header {
    display: flex;
    align-items: flex-start;
    gap: 0.75rem;
    margin-bottom: 1.25rem;
  }

  .letter-badge {
    width: 2.5rem;
    height: 2.5rem;
    border-radius: 0.5rem;
    display: flex;
    align-items: center;
    justify-content: center;
    font-weight: 800;
    font-size: 1.1rem;
    flex-shrink: 0;
    background-color: #f3f4f6;
    color: #6b7280;
  }

  .letter-badge.letter-winner {
    background-color: #2563eb;
    color: white;
  }

  .card-info {
    flex: 1;
    min-width: 0;
  }

  .card-title {
    font-size: 1.05rem;
    font-weight: 700;
    color: #0f172a;
    margin: 0 0 0.25rem;
  }

  .card-description {
    font-size: 0.85rem;
    color: #64748b;
    margin: 0;
    line-height: 1.4;
  }

  .metrics {
    display: flex;
    flex-direction: column;
    gap: 0.6rem;
    margin-bottom: 1.25rem;
  }

  .metric-row {
    display: flex;
    align-items: center;
    gap: 0.5rem;
  }

  .metric-label {
    font-size: 0.75rem;
    font-weight: 600;
    color: #64748b;
    width: 2rem;
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
    width: 2rem;
    text-align: right;
    flex-shrink: 0;
  }

  .card-footer {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding-top: 1rem;
    border-top: 1px solid #f1f5f9;
  }

  .footer-label {
    font-size: 0.7rem;
    color: #94a3b8;
    text-transform: uppercase;
    letter-spacing: 0.05em;
    display: block;
  }

  .footer-value {
    font-size: 0.9rem;
    font-weight: 600;
    color: #334155;
  }

  .score-badge {
    display: flex;
    flex-direction: column;
    align-items: center;
    background: #f1f5f9;
    padding: 0.4rem 0.85rem;
    border-radius: 0.5rem;
  }

  .score-badge.score-winner {
    background: linear-gradient(135deg, #2563eb, #1d4ed8);
  }

  .score-label {
    font-size: 0.6rem;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 0.05em;
    color: #94a3b8;
  }

  .score-winner .score-label {
    color: rgba(255, 255, 255, 0.8);
  }

  .score-value {
    font-size: 1.15rem;
    font-weight: 800;
    color: #0f172a;
  }

  .score-winner .score-value {
    color: white;
  }
</style>
