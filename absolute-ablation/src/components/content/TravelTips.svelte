<script lang="ts">
  interface Tip {
    id: string;
    destination: string;
    text: string;
    category: string;
    timestamp: number;
  }

  interface Props {
    storageKey?: string;
    destinations?: string[];
  }

  let { storageKey = 'travel-tips-ch-2025', destinations = [] }: Props = $props();

  let tips: Tip[] = $state([]);
  let newTipText = $state('');
  let newTipDestination = $state('');
  let newTipCategory = $state('general');
  let filterDestination = $state('all');
  let showForm = $state(false);
  let justSaved = $state(false);

  const categories = [
    { value: 'general', label: 'General', icon: 'fa-lightbulb' },
    { value: 'food', label: 'Food & Drink', icon: 'fa-utensils' },
    { value: 'transport', label: 'Transport', icon: 'fa-car' },
    { value: 'accommodation', label: 'Accommodation', icon: 'fa-bed' },
    { value: 'activity', label: 'Activity', icon: 'fa-hiking' },
    { value: 'kids', label: 'Kids', icon: 'fa-baby' },
    { value: 'senior', label: 'Accessibility', icon: 'fa-wheelchair' },
    { value: 'budget', label: 'Budget', icon: 'fa-wallet' },
  ];

  const categoryMap = Object.fromEntries(categories.map(c => [c.value, c]));

  let filteredTips = $derived(
    filterDestination === 'all'
      ? tips
      : tips.filter(t => t.destination === filterDestination)
  );

  let tipCount = $derived(tips.length);

  function loadTips() {
    try {
      const stored = localStorage.getItem(storageKey);
      if (stored) {
        tips = JSON.parse(stored);
      }
    } catch {
      tips = [];
    }
  }

  function saveTips() {
    try {
      localStorage.setItem(storageKey, JSON.stringify(tips));
    } catch {
      // localStorage might be full or unavailable
    }
  }

  function addTip() {
    if (!newTipText.trim()) return;
    const tip: Tip = {
      id: crypto.randomUUID ? crypto.randomUUID() : Date.now().toString(36) + Math.random().toString(36).slice(2),
      destination: newTipDestination || 'General',
      text: newTipText.trim(),
      category: newTipCategory,
      timestamp: Date.now(),
    };
    tips = [tip, ...tips];
    saveTips();
    newTipText = '';
    newTipCategory = 'general';
    justSaved = true;
    setTimeout(() => { justSaved = false; }, 1500);
  }

  function deleteTip(id: string) {
    tips = tips.filter(t => t.id !== id);
    saveTips();
  }

  function exportTips() {
    const text = tips.map(t => `[${t.destination}] (${t.category}) ${t.text}`).join('\n');
    const blob = new Blob([text], { type: 'text/plain' });
    const url = URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = 'travel-tips.txt';
    a.click();
    URL.revokeObjectURL(url);
  }

  function clearAll() {
    if (confirm('Delete all your saved tips? This cannot be undone.')) {
      tips = [];
      saveTips();
    }
  }

  function formatDate(ts: number) {
    return new Date(ts).toLocaleDateString('en-GB', { day: 'numeric', month: 'short' });
  }

  $effect(() => {
    loadTips();
    if (!newTipDestination && destinations.length > 0) {
      newTipDestination = destinations[0];
    }
  });
</script>

<div class="tips-container">
  <div class="tips-header">
    <div class="tips-title-row">
      <div class="tips-title">
        <span class="tips-icon"><i class="fas fa-bookmark"></i></span>
        <h3>Your Travel Notes</h3>
      </div>
      <span class="tips-badge">{tipCount} {tipCount === 1 ? 'tip' : 'tips'} saved</span>
    </div>
    <p class="tips-subtitle">Save personal tips and notes for this trip. Stored locally in your browser -- private to you.</p>
  </div>

  <div class="tips-actions-bar">
    <button class="btn btn-primary" onclick={() => showForm = !showForm}>
      <i class="fas {showForm ? 'fa-times' : 'fa-plus'}"></i>
      {showForm ? 'Cancel' : 'Add a tip'}
    </button>
    {#if tips.length > 0}
      <div class="tips-right-actions">
        <button class="btn btn-ghost" onclick={exportTips} title="Export tips as text">
          <i class="fas fa-download"></i>
          Export
        </button>
        <button class="btn btn-ghost btn-danger" onclick={clearAll} title="Delete all tips">
          <i class="fas fa-trash"></i>
        </button>
      </div>
    {/if}
  </div>

  {#if showForm}
    <div class="tip-form" role="form">
      <div class="form-row">
        <div class="form-group">
          <label for="tip-dest">Destination</label>
          <select id="tip-dest" bind:value={newTipDestination}>
            {#each destinations as dest}
              <option value={dest}>{dest}</option>
            {/each}
            <option value="General">General</option>
          </select>
        </div>
        <div class="form-group">
          <label for="tip-cat">Category</label>
          <select id="tip-cat" bind:value={newTipCategory}>
            {#each categories as cat}
              <option value={cat.value}>{cat.label}</option>
            {/each}
          </select>
        </div>
      </div>
      <div class="form-group">
        <label for="tip-text">Your tip or note</label>
        <textarea
          id="tip-text"
          bind:value={newTipText}
          placeholder="e.g. Book Rigi tickets online in advance -- saves queueing with kids..."
          rows="3"
          onkeydown={(e) => { if (e.key === 'Enter' && e.metaKey) addTip(); }}
        ></textarea>
      </div>
      <div class="form-submit-row">
        <button class="btn btn-primary" onclick={addTip} disabled={!newTipText.trim()}>
          <i class="fas fa-check"></i>
          Save tip
        </button>
        {#if justSaved}
          <span class="saved-indicator"><i class="fas fa-check-circle"></i> Saved!</span>
        {/if}
      </div>
    </div>
  {/if}

  {#if tips.length > 0}
    <div class="filter-bar">
      <button class="filter-btn" class:active={filterDestination === 'all'} onclick={() => filterDestination = 'all'}>All</button>
      {#each destinations as dest}
        {#if tips.some(t => t.destination === dest)}
          <button class="filter-btn" class:active={filterDestination === dest} onclick={() => filterDestination = dest}>
            {dest}
          </button>
        {/if}
      {/each}
    </div>

    <div class="tips-list">
      {#each filteredTips as tip (tip.id)}
        <div class="tip-item">
          <div class="tip-item-header">
            <span class="tip-category-badge">
              <i class="fas {categoryMap[tip.category]?.icon ?? 'fa-lightbulb'}"></i>
              {categoryMap[tip.category]?.label ?? tip.category}
            </span>
            <span class="tip-meta">
              <span class="tip-dest">{tip.destination}</span>
              <span class="tip-date">{formatDate(tip.timestamp)}</span>
            </span>
          </div>
          <p class="tip-text">{tip.text}</p>
          <button class="tip-delete" onclick={() => deleteTip(tip.id)} title="Delete this tip">
            <i class="fas fa-times"></i>
          </button>
        </div>
      {/each}
    </div>
  {:else if !showForm}
    <div class="tips-empty">
      <i class="fas fa-sticky-note"></i>
      <p>No tips yet. Add your first one to start building your personal travel notes.</p>
    </div>
  {/if}
</div>

<style>
  .tips-container {
    background: linear-gradient(135deg, #f8faff, #f0f4ff);
    border: 1px solid #c7d2fe;
    border-radius: 1rem;
    padding: 1.5rem;
    margin: 2rem 0;
  }

  .tips-header {
    margin-bottom: 1rem;
  }

  .tips-title-row {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 0.75rem;
    flex-wrap: wrap;
  }

  .tips-title {
    display: flex;
    align-items: center;
    gap: 0.6rem;
  }

  .tips-title h3 {
    margin: 0;
    font-size: 1.1rem;
    font-weight: 700;
    color: #1e293b;
  }

  .tips-icon {
    width: 2rem;
    height: 2rem;
    border-radius: 0.5rem;
    background: #4f46e5;
    color: white;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 0.8rem;
  }

  .tips-badge {
    font-size: 0.75rem;
    font-weight: 600;
    color: #6366f1;
    background: white;
    border: 1px solid #e0e7ff;
    padding: 0.2rem 0.6rem;
    border-radius: 999px;
  }

  .tips-subtitle {
    font-size: 0.8rem;
    color: #64748b;
    margin: 0.4rem 0 0;
    line-height: 1.4;
  }

  .tips-actions-bar {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 0.5rem;
    margin-bottom: 0.75rem;
  }

  .tips-right-actions {
    display: flex;
    gap: 0.35rem;
  }

  .btn {
    font-size: 0.8rem;
    font-weight: 600;
    padding: 0.45rem 0.85rem;
    border-radius: 0.5rem;
    border: none;
    cursor: pointer;
    display: inline-flex;
    align-items: center;
    gap: 0.4rem;
    transition: all 0.15s ease;
  }

  .btn-primary {
    background: #4f46e5;
    color: white;
  }

  .btn-primary:hover {
    background: #4338ca;
  }

  .btn-primary:disabled {
    background: #a5b4fc;
    cursor: not-allowed;
  }

  .btn-ghost {
    background: transparent;
    color: #6366f1;
    border: 1px solid #e0e7ff;
  }

  .btn-ghost:hover {
    background: white;
  }

  .btn-danger:hover {
    color: #dc2626;
    border-color: #fecaca;
    background: #fff5f5;
  }

  .tip-form {
    background: white;
    border: 1px solid #e0e7ff;
    border-radius: 0.75rem;
    padding: 1.25rem;
    margin-bottom: 1rem;
  }

  .form-row {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 0.75rem;
    margin-bottom: 0.75rem;
  }

  .form-group {
    display: flex;
    flex-direction: column;
    gap: 0.3rem;
  }

  .form-group label {
    font-size: 0.75rem;
    font-weight: 600;
    color: #475569;
    text-transform: uppercase;
    letter-spacing: 0.03em;
  }

  .form-group select,
  .form-group textarea {
    font-size: 0.85rem;
    padding: 0.5rem 0.65rem;
    border: 1px solid #d1d5db;
    border-radius: 0.4rem;
    background: #fafbff;
    color: #334155;
    font-family: inherit;
    transition: border-color 0.15s;
  }

  .form-group select:focus,
  .form-group textarea:focus {
    outline: none;
    border-color: #6366f1;
    box-shadow: 0 0 0 2px rgba(99, 102, 241, 0.1);
  }

  .form-group textarea {
    resize: vertical;
    min-height: 3.5rem;
  }

  .form-submit-row {
    display: flex;
    align-items: center;
    gap: 0.75rem;
    margin-top: 0.75rem;
  }

  .saved-indicator {
    font-size: 0.8rem;
    color: #16a34a;
    font-weight: 600;
    animation: fadeIn 0.2s ease;
  }

  @keyframes fadeIn {
    from { opacity: 0; transform: translateY(4px); }
    to { opacity: 1; transform: translateY(0); }
  }

  .filter-bar {
    display: flex;
    gap: 0.35rem;
    flex-wrap: wrap;
    margin-bottom: 0.75rem;
    padding-bottom: 0.6rem;
    border-bottom: 1px solid #e0e7ff;
  }

  .filter-btn {
    font-size: 0.72rem;
    font-weight: 600;
    padding: 0.3rem 0.6rem;
    border-radius: 999px;
    border: 1px solid #e0e7ff;
    background: white;
    color: #64748b;
    cursor: pointer;
    transition: all 0.15s;
  }

  .filter-btn:hover {
    border-color: #a5b4fc;
    color: #4f46e5;
  }

  .filter-btn.active {
    background: #4f46e5;
    color: white;
    border-color: #4f46e5;
  }

  .tips-list {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }

  .tip-item {
    background: white;
    border: 1px solid #e5e7eb;
    border-radius: 0.6rem;
    padding: 0.85rem 1rem;
    position: relative;
    transition: box-shadow 0.15s;
  }

  .tip-item:hover {
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
  }

  .tip-item-header {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 0.5rem;
    margin-bottom: 0.4rem;
    flex-wrap: wrap;
  }

  .tip-category-badge {
    font-size: 0.7rem;
    font-weight: 600;
    color: #6366f1;
    background: #eef2ff;
    padding: 0.15rem 0.5rem;
    border-radius: 999px;
    display: inline-flex;
    align-items: center;
    gap: 0.3rem;
  }

  .tip-meta {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    font-size: 0.7rem;
    color: #94a3b8;
  }

  .tip-dest {
    font-weight: 600;
    color: #64748b;
  }

  .tip-text {
    font-size: 0.85rem;
    color: #334155;
    line-height: 1.5;
    margin: 0;
    padding-right: 1.5rem;
  }

  .tip-delete {
    position: absolute;
    top: 0.6rem;
    right: 0.6rem;
    background: none;
    border: none;
    color: #cbd5e1;
    cursor: pointer;
    font-size: 0.7rem;
    padding: 0.25rem;
    border-radius: 0.25rem;
    transition: all 0.15s;
  }

  .tip-delete:hover {
    color: #ef4444;
    background: #fef2f2;
  }

  .tips-empty {
    text-align: center;
    padding: 2rem 1rem;
    color: #94a3b8;
  }

  .tips-empty i {
    font-size: 1.5rem;
    margin-bottom: 0.5rem;
    display: block;
  }

  .tips-empty p {
    font-size: 0.8rem;
    margin: 0;
    line-height: 1.5;
  }

  @media (max-width: 480px) {
    .form-row {
      grid-template-columns: 1fr;
    }
    .tips-actions-bar {
      flex-wrap: wrap;
    }
  }
</style>
