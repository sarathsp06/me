<script lang="ts">
  interface PackingItem {
    id: string;
    text: string;
    category: string;
    checked: boolean;
    custom: boolean;
  }

  interface CategoryDef {
    name: string;
    icon: string;
    items: string[];
  }

  interface Props {
    storageKey?: string;
    categories?: CategoryDef[];
  }

  let { storageKey = 'packing-checklist', categories = [] }: Props = $props();

  let items: PackingItem[] = $state([]);
  let initialized = $state(false);
  let newItemText = $state('');
  let newItemCategory = $state('');
  let showAddForm = $state(false);
  let expandedCategories: Record<string, boolean> = $state({});

  let totalCount = $derived(items.length);
  let checkedCount = $derived(items.filter(i => i.checked).length);
  let progressPercent = $derived(totalCount > 0 ? Math.round((checkedCount / totalCount) * 100) : 0);

  function categoryStats(catName: string) {
    const catItems = items.filter(i => i.category === catName);
    const catChecked = catItems.filter(i => i.checked).length;
    return { total: catItems.length, checked: catChecked };
  }

  function buildDefaultItems(): PackingItem[] {
    const result: PackingItem[] = [];
    for (const cat of categories) {
      for (const itemText of cat.items) {
        result.push({
          id: `${cat.name}-${itemText}`.replace(/\s+/g, '-').toLowerCase().slice(0, 60) + '-' + Math.random().toString(36).slice(2, 6),
          text: itemText,
          category: cat.name,
          checked: false,
          custom: false,
        });
      }
    }
    return result;
  }

  function load() {
    try {
      const stored = localStorage.getItem(storageKey);
      if (stored) {
        const parsed = JSON.parse(stored);
        if (Array.isArray(parsed) && parsed.length > 0) {
          items = parsed;
          initialized = true;
          return;
        }
      }
    } catch {
      // fall through
    }
    items = buildDefaultItems();
    initialized = true;
    save();
  }

  function save() {
    try {
      localStorage.setItem(storageKey, JSON.stringify(items));
    } catch {
      // localStorage might be full
    }
  }

  function toggle(id: string) {
    items = items.map(i => i.id === id ? { ...i, checked: !i.checked } : i);
    save();
  }

  function addItem() {
    if (!newItemText.trim() || !newItemCategory) return;
    const item: PackingItem = {
      id: Date.now().toString(36) + Math.random().toString(36).slice(2, 6),
      text: newItemText.trim(),
      category: newItemCategory,
      checked: false,
      custom: true,
    };
    items = [...items, item];
    save();
    newItemText = '';
    showAddForm = false;
  }

  function removeCustomItem(id: string) {
    items = items.filter(i => i.id !== id);
    save();
  }

  function resetAll() {
    if (confirm('Reset the entire packing list? Custom items will be removed and all checkmarks cleared.')) {
      items = buildDefaultItems();
      save();
    }
  }

  function exportList() {
    const lines: string[] = [];
    for (const cat of categories) {
      lines.push(`\n--- ${cat.name} ---`);
      const catItems = items.filter(i => i.category === cat.name);
      for (const item of catItems) {
        lines.push(`${item.checked ? '[x]' : '[ ]'} ${item.text}`);
      }
    }
    // custom items not in predefined categories
    const customCats = [...new Set(items.filter(i => i.custom && !categories.some(c => c.name === i.category)).map(i => i.category))];
    for (const cc of customCats) {
      lines.push(`\n--- ${cc} ---`);
      const catItems = items.filter(i => i.category === cc);
      for (const item of catItems) {
        lines.push(`${item.checked ? '[x]' : '[ ]'} ${item.text}`);
      }
    }
    lines.unshift(`Packing Checklist — ${checkedCount}/${totalCount} packed`);
    const blob = new Blob([lines.join('\n')], { type: 'text/plain' });
    const url = URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = 'packing-checklist.txt';
    a.click();
    URL.revokeObjectURL(url);
  }

  function toggleCategory(catName: string) {
    expandedCategories = { ...expandedCategories, [catName]: !expandedCategories[catName] };
  }

  function isCategoryExpanded(catName: string): boolean {
    return expandedCategories[catName] !== false; // default expanded
  }

  $effect(() => {
    load();
    if (!newItemCategory && categories.length > 0) {
      newItemCategory = categories[0].name;
    }
    // default all categories expanded
    const exp: Record<string, boolean> = {};
    for (const cat of categories) {
      exp[cat.name] = true;
    }
    expandedCategories = exp;
  });
</script>

<div class="bg-gradient-to-br from-green-50 to-[#f7fef9] border border-green-200 rounded-2xl p-6 my-8">
  <div class="mb-4">
    <div class="flex items-center justify-between gap-3 flex-wrap">
      <div class="flex items-center gap-2.5">
        <span class="w-8 h-8 rounded-lg bg-green-600 text-white flex items-center justify-center text-[0.8rem]"><i class="fas fa-suitcase"></i></span>
        <h3 class="m-0 text-[1.1rem] font-bold text-slate-800">Packing Checklist</h3>
      </div>
      <span class="text-xs font-semibold text-green-600 bg-white border border-green-200 py-0.5 px-2.5 rounded-full">{checkedCount}/{totalCount} packed</span>
    </div>
    <p class="text-[0.8rem] text-slate-500 mt-1.5 mb-0 leading-snug">Tick items off as you pack. Everything saves automatically in your browser.</p>

    <div class="mt-3 h-1.5 bg-green-100 rounded-full overflow-hidden">
      <div class="h-full bg-gradient-to-r from-green-500 to-green-600 rounded-full transition-[width] duration-300 ease-in-out" style="width: {progressPercent}%"></div>
    </div>
    <p class="text-[0.72rem] text-green-600 font-semibold mt-1 mb-0 text-right">{progressPercent}% ready</p>
  </div>

  <div class="flex items-center justify-between gap-2 mb-3 max-[480px]:flex-wrap">
    <button class="text-[0.8rem] font-semibold py-1.5 px-3.5 rounded-lg border-none cursor-pointer inline-flex items-center gap-1.5 transition-all duration-150 bg-green-600 text-white hover:bg-green-700" onclick={() => showAddForm = !showAddForm}>
      <i class="fas {showAddForm ? 'fa-times' : 'fa-plus'}"></i>
      {showAddForm ? 'Cancel' : 'Add item'}
    </button>
    <div class="flex gap-1">
      <button class="text-[0.8rem] font-semibold py-1.5 px-3.5 rounded-lg cursor-pointer inline-flex items-center gap-1.5 transition-all duration-150 bg-transparent text-green-600 border border-green-200 hover:bg-white" onclick={exportList} title="Export as text">
        <i class="fas fa-download"></i>
        Export
      </button>
      <button class="text-[0.8rem] font-semibold py-1.5 px-3.5 rounded-lg cursor-pointer inline-flex items-center gap-1.5 transition-all duration-150 bg-transparent text-green-600 border border-green-200 hover:text-red-600 hover:border-red-200 hover:bg-red-50" onclick={resetAll} title="Reset list">
        <i class="fas fa-undo"></i>
      </button>
    </div>
  </div>

  {#if showAddForm}
    <div class="bg-white border border-green-200 rounded-xl p-4 mb-4" role="form">
      <div class="grid grid-cols-[auto_1fr] gap-3 mb-3 max-[480px]:grid-cols-1">
        <div class="flex flex-col gap-1">
          <label for="pack-cat" class="text-[0.72rem] font-semibold text-slate-600 uppercase tracking-wide">Category</label>
          <select id="pack-cat" bind:value={newItemCategory} class="text-[0.85rem] py-2 px-2.5 border border-gray-300 rounded bg-[#fafff5] text-slate-700 font-[inherit] transition-colors duration-150 focus:outline-none focus:border-green-600 focus:ring-2 focus:ring-green-600/10">
            {#each categories as cat}
              <option value={cat.name}>{cat.name}</option>
            {/each}
          </select>
        </div>
        <div class="flex flex-col gap-1 min-w-0">
          <label for="pack-item" class="text-[0.72rem] font-semibold text-slate-600 uppercase tracking-wide">Item</label>
          <input
            id="pack-item"
            type="text"
            bind:value={newItemText}
            placeholder="e.g. Saanvi's swim nappy"
            onkeydown={(e) => { if (e.key === 'Enter') addItem(); }}
            class="text-[0.85rem] py-2 px-2.5 border border-gray-300 rounded bg-[#fafff5] text-slate-700 font-[inherit] transition-colors duration-150 focus:outline-none focus:border-green-600 focus:ring-2 focus:ring-green-600/10"
          />
        </div>
      </div>
      <button class="text-xs font-semibold py-1.5 px-3 rounded-lg border-none cursor-pointer inline-flex items-center gap-1.5 transition-all duration-150 bg-green-600 text-white hover:bg-green-700 disabled:bg-green-300 disabled:cursor-not-allowed" onclick={addItem} disabled={!newItemText.trim()}>
        <i class="fas fa-check"></i> Add
      </button>
    </div>
  {/if}

  {#if initialized}
    <div class="flex flex-col gap-2">
      {#each categories as cat}
        {@const stats = categoryStats(cat.name)}
        {@const expanded = isCategoryExpanded(cat.name)}
        {@const catDone = stats.checked === stats.total && stats.total > 0}
        <div class="bg-white border rounded-[0.6rem] overflow-hidden transition-colors duration-200" class:border-green-300={catDone} class:bg-green-50={catDone} class:border-gray-200={!catDone}>
          <button class="flex items-center justify-between w-full py-3 px-4 bg-none border-none cursor-pointer font-[inherit] transition-colors duration-100 hover:bg-slate-50" onclick={() => toggleCategory(cat.name)}>
            <div class="flex items-center gap-2.5">
              <i class="fas {cat.icon} text-[0.85rem] text-green-600 w-5 text-center"></i>
              <span class="text-[0.85rem] font-bold text-slate-800">{cat.name}</span>
              <span class="text-[0.7rem] font-semibold py-0.5 px-2 rounded-full" class:text-green-600={catDone} class:bg-green-100={catDone} class:text-slate-500={!catDone} class:bg-slate-100={!catDone}>{stats.checked}/{stats.total}</span>
            </div>
            <i class="fas {expanded ? 'fa-chevron-up' : 'fa-chevron-down'} text-[0.65rem] text-slate-400"></i>
          </button>
          {#if expanded}
            <div class="px-2 pb-2">
              {#each items.filter(i => i.category === cat.name) as item (item.id)}
                <label class="flex items-center gap-2.5 py-1.5 px-2 rounded cursor-pointer transition-colors duration-100 relative hover:bg-slate-50" class:opacity-55={item.checked}>
                  <input
                    type="checkbox"
                    checked={item.checked}
                    onchange={() => toggle(item.id)}
                    class="w-[1.1rem] h-[1.1rem] accent-green-600 cursor-pointer shrink-0"
                  />
                  <span class="text-[0.82rem] leading-snug flex-1" class:line-through={item.checked} class:text-slate-400={item.checked} class:text-slate-700={!item.checked}>{item.text}</span>
                  {#if item.custom}
                    <button class="bg-none border-none text-slate-300 cursor-pointer text-[0.65rem] p-0.5 rounded-sm transition-all duration-150 shrink-0 hover:text-red-500 hover:bg-red-50" onclick={(e) => { e.stopPropagation(); removeCustomItem(item.id); }} title="Remove">
                      <i class="fas fa-times"></i>
                    </button>
                  {/if}
                </label>
              {/each}
            </div>
          {/if}
        </div>
      {/each}
    </div>
  {/if}
</div>
