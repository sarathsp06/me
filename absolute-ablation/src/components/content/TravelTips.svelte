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

<div class="bg-gradient-to-br from-[#f8faff] to-indigo-50 border border-indigo-200 rounded-2xl p-6 my-8">
  <div class="mb-4">
    <div class="flex items-center justify-between gap-3 flex-wrap">
      <div class="flex items-center gap-2.5">
        <span class="w-8 h-8 rounded-lg bg-indigo-600 text-white flex items-center justify-center text-[0.8rem]"><i class="fas fa-bookmark"></i></span>
        <h3 class="m-0 text-[1.1rem] font-bold text-slate-800">Your Travel Notes</h3>
      </div>
      <span class="text-xs font-semibold text-indigo-500 bg-white border border-indigo-100 py-0.5 px-2.5 rounded-full">{tipCount} {tipCount === 1 ? 'tip' : 'tips'} saved</span>
    </div>
    <p class="text-[0.8rem] text-slate-500 mt-1.5 mb-0 leading-snug">Save personal tips and notes for this trip. Stored locally in your browser -- private to you.</p>
  </div>

  <div class="flex items-center justify-between gap-2 mb-3 max-[480px]:flex-wrap">
    <button class="text-[0.8rem] font-semibold py-1.5 px-3.5 rounded-lg border-none cursor-pointer inline-flex items-center gap-1.5 transition-all duration-150 bg-indigo-600 text-white hover:bg-indigo-700" onclick={() => showForm = !showForm}>
      <i class="fas {showForm ? 'fa-times' : 'fa-plus'}"></i>
      {showForm ? 'Cancel' : 'Add a tip'}
    </button>
    {#if tips.length > 0}
      <div class="flex gap-1">
        <button class="text-[0.8rem] font-semibold py-1.5 px-3.5 rounded-lg cursor-pointer inline-flex items-center gap-1.5 transition-all duration-150 bg-transparent text-indigo-500 border border-indigo-100 hover:bg-white" onclick={exportTips} title="Export tips as text">
          <i class="fas fa-download"></i>
          Export
        </button>
        <button class="text-[0.8rem] font-semibold py-1.5 px-3.5 rounded-lg cursor-pointer inline-flex items-center gap-1.5 transition-all duration-150 bg-transparent text-indigo-500 border border-indigo-100 hover:text-red-600 hover:border-red-200 hover:bg-red-50" onclick={clearAll} title="Delete all tips">
          <i class="fas fa-trash"></i>
        </button>
      </div>
    {/if}
  </div>

  {#if showForm}
    <div class="bg-white border border-indigo-100 rounded-xl p-5 mb-4" role="form">
      <div class="grid grid-cols-2 gap-3 mb-3 max-[480px]:grid-cols-1">
        <div class="flex flex-col gap-1">
          <label for="tip-dest" class="text-xs font-semibold text-slate-600 uppercase tracking-wide">Destination</label>
          <select id="tip-dest" bind:value={newTipDestination} class="text-[0.85rem] py-2 px-2.5 border border-gray-300 rounded bg-[#fafbff] text-slate-700 font-[inherit] transition-colors duration-150 focus:outline-none focus:border-indigo-500 focus:ring-2 focus:ring-indigo-500/10">
            {#each destinations as dest}
              <option value={dest}>{dest}</option>
            {/each}
            <option value="General">General</option>
          </select>
        </div>
        <div class="flex flex-col gap-1">
          <label for="tip-cat" class="text-xs font-semibold text-slate-600 uppercase tracking-wide">Category</label>
          <select id="tip-cat" bind:value={newTipCategory} class="text-[0.85rem] py-2 px-2.5 border border-gray-300 rounded bg-[#fafbff] text-slate-700 font-[inherit] transition-colors duration-150 focus:outline-none focus:border-indigo-500 focus:ring-2 focus:ring-indigo-500/10">
            {#each categories as cat}
              <option value={cat.value}>{cat.label}</option>
            {/each}
          </select>
        </div>
      </div>
      <div class="flex flex-col gap-1">
        <label for="tip-text" class="text-xs font-semibold text-slate-600 uppercase tracking-wide">Your tip or note</label>
        <textarea
          id="tip-text"
          bind:value={newTipText}
          placeholder="e.g. Book Rigi tickets online in advance -- saves queueing with kids..."
          rows="3"
          onkeydown={(e) => { if (e.key === 'Enter' && e.metaKey) addTip(); }}
          class="text-[0.85rem] py-2 px-2.5 border border-gray-300 rounded bg-[#fafbff] text-slate-700 font-[inherit] transition-colors duration-150 resize-y min-h-14 focus:outline-none focus:border-indigo-500 focus:ring-2 focus:ring-indigo-500/10"
        ></textarea>
      </div>
      <div class="flex items-center gap-3 mt-3">
        <button class="text-[0.8rem] font-semibold py-1.5 px-3.5 rounded-lg border-none cursor-pointer inline-flex items-center gap-1.5 transition-all duration-150 bg-indigo-600 text-white hover:bg-indigo-700 disabled:bg-indigo-300 disabled:cursor-not-allowed" onclick={addTip} disabled={!newTipText.trim()}>
          <i class="fas fa-check"></i>
          Save tip
        </button>
        {#if justSaved}
          <span class="text-[0.8rem] text-green-600 font-semibold animate-[fadeIn_0.2s_ease]"><i class="fas fa-check-circle"></i> Saved!</span>
        {/if}
      </div>
    </div>
  {/if}

  {#if tips.length > 0}
    <div class="flex gap-1 flex-wrap mb-3 pb-2.5 border-b border-indigo-100">
      <button class="text-[0.72rem] font-semibold py-1 px-2.5 rounded-full border border-indigo-100 cursor-pointer transition-all duration-150 hover:border-indigo-300 hover:text-indigo-600" class:bg-indigo-600={filterDestination === 'all'} class:text-white={filterDestination === 'all'} class:border-indigo-600={filterDestination === 'all'} class:bg-white={filterDestination !== 'all'} class:text-slate-500={filterDestination !== 'all'} onclick={() => filterDestination = 'all'}>All</button>
      {#each destinations as dest}
        {#if tips.some(t => t.destination === dest)}
          <button class="text-[0.72rem] font-semibold py-1 px-2.5 rounded-full border border-indigo-100 cursor-pointer transition-all duration-150 hover:border-indigo-300 hover:text-indigo-600" class:bg-indigo-600={filterDestination === dest} class:text-white={filterDestination === dest} class:border-indigo-600={filterDestination === dest} class:bg-white={filterDestination !== dest} class:text-slate-500={filterDestination !== dest} onclick={() => filterDestination = dest}>
            {dest}
          </button>
        {/if}
      {/each}
    </div>

    <div class="flex flex-col gap-2">
      {#each filteredTips as tip (tip.id)}
        <div class="bg-white border border-gray-200 rounded-[0.6rem] py-3.5 px-4 relative transition-shadow duration-150 hover:shadow-[0_2px_8px_rgba(0,0,0,0.05)]">
          <div class="flex items-center justify-between gap-2 mb-1.5 flex-wrap">
            <span class="text-[0.7rem] font-semibold text-indigo-500 bg-indigo-50 py-0.5 px-2 rounded-full inline-flex items-center gap-1">
              <i class="fas {categoryMap[tip.category]?.icon ?? 'fa-lightbulb'}"></i>
              {categoryMap[tip.category]?.label ?? tip.category}
            </span>
            <span class="flex items-center gap-2 text-[0.7rem] text-slate-400">
              <span class="font-semibold text-slate-500">{tip.destination}</span>
              <span>{formatDate(tip.timestamp)}</span>
            </span>
          </div>
          <p class="text-[0.85rem] text-slate-700 leading-normal m-0 pr-6">{tip.text}</p>
          <button class="absolute top-2.5 right-2.5 bg-none border-none text-slate-300 cursor-pointer text-[0.7rem] p-1 rounded transition-all duration-150 hover:text-red-500 hover:bg-red-50" onclick={() => deleteTip(tip.id)} title="Delete this tip">
            <i class="fas fa-times"></i>
          </button>
        </div>
      {/each}
    </div>
  {:else if !showForm}
    <div class="text-center py-8 px-4 text-slate-400">
      <i class="fas fa-sticky-note text-2xl mb-2 block"></i>
      <p class="text-[0.8rem] m-0 leading-normal">No tips yet. Add your first one to start building your personal travel notes.</p>
    </div>
  {/if}
</div>
