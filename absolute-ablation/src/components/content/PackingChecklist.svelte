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

<div class="checklist-container">
  <div class="checklist-header">
    <div class="checklist-title-row">
      <div class="checklist-title">
        <span class="checklist-icon"><i class="fas fa-suitcase"></i></span>
        <h3>Packing Checklist</h3>
      </div>
      <span class="checklist-badge">{checkedCount}/{totalCount} packed</span>
    </div>
    <p class="checklist-subtitle">Tick items off as you pack. Everything saves automatically in your browser.</p>

    <div class="progress-bar-container">
      <div class="progress-bar" style="width: {progressPercent}%"></div>
    </div>
    <p class="progress-text">{progressPercent}% ready</p>
  </div>

  <div class="checklist-actions-bar">
    <button class="btn btn-primary" onclick={() => showAddForm = !showAddForm}>
      <i class="fas {showAddForm ? 'fa-times' : 'fa-plus'}"></i>
      {showAddForm ? 'Cancel' : 'Add item'}
    </button>
    <div class="checklist-right-actions">
      <button class="btn btn-ghost" onclick={exportList} title="Export as text">
        <i class="fas fa-download"></i>
        Export
      </button>
      <button class="btn btn-ghost btn-danger" onclick={resetAll} title="Reset list">
        <i class="fas fa-undo"></i>
      </button>
    </div>
  </div>

  {#if showAddForm}
    <div class="add-form" role="form">
      <div class="form-row">
        <div class="form-group">
          <label for="pack-cat">Category</label>
          <select id="pack-cat" bind:value={newItemCategory}>
            {#each categories as cat}
              <option value={cat.name}>{cat.name}</option>
            {/each}
          </select>
        </div>
        <div class="form-group form-group-grow">
          <label for="pack-item">Item</label>
          <input
            id="pack-item"
            type="text"
            bind:value={newItemText}
            placeholder="e.g. Saanvi's swim nappy"
            onkeydown={(e) => { if (e.key === 'Enter') addItem(); }}
          />
        </div>
      </div>
      <button class="btn btn-primary btn-sm" onclick={addItem} disabled={!newItemText.trim()}>
        <i class="fas fa-check"></i> Add
      </button>
    </div>
  {/if}

  {#if initialized}
    <div class="categories-list">
      {#each categories as cat}
        {@const stats = categoryStats(cat.name)}
        {@const expanded = isCategoryExpanded(cat.name)}
        {@const catDone = stats.checked === stats.total && stats.total > 0}
        <div class="category-section" class:category-done={catDone}>
          <button class="category-header" onclick={() => toggleCategory(cat.name)}>
            <div class="category-left">
              <i class="fas {cat.icon} category-icon"></i>
              <span class="category-name">{cat.name}</span>
              <span class="category-count" class:count-done={catDone}>{stats.checked}/{stats.total}</span>
            </div>
            <i class="fas {expanded ? 'fa-chevron-up' : 'fa-chevron-down'} category-toggle"></i>
          </button>
          {#if expanded}
            <div class="category-items">
              {#each items.filter(i => i.category === cat.name) as item (item.id)}
                <label class="pack-item" class:pack-item-checked={item.checked}>
                  <input
                    type="checkbox"
                    checked={item.checked}
                    onchange={() => toggle(item.id)}
                    class="pack-checkbox"
                  />
                  <span class="pack-text">{item.text}</span>
                  {#if item.custom}
                    <button class="pack-remove" onclick={(e) => { e.stopPropagation(); removeCustomItem(item.id); }} title="Remove">
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

<style>
  .checklist-container {
    background: linear-gradient(135deg, #f0fdf4, #f7fef9);
    border: 1px solid #bbf7d0;
    border-radius: 1rem;
    padding: 1.5rem;
    margin: 2rem 0;
  }

  .checklist-header {
    margin-bottom: 1rem;
  }

  .checklist-title-row {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 0.75rem;
    flex-wrap: wrap;
  }

  .checklist-title {
    display: flex;
    align-items: center;
    gap: 0.6rem;
  }

  .checklist-title h3 {
    margin: 0;
    font-size: 1.1rem;
    font-weight: 700;
    color: #1e293b;
  }

  .checklist-icon {
    width: 2rem;
    height: 2rem;
    border-radius: 0.5rem;
    background: #16a34a;
    color: white;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 0.8rem;
  }

  .checklist-badge {
    font-size: 0.75rem;
    font-weight: 600;
    color: #16a34a;
    background: white;
    border: 1px solid #bbf7d0;
    padding: 0.2rem 0.6rem;
    border-radius: 999px;
  }

  .checklist-subtitle {
    font-size: 0.8rem;
    color: #64748b;
    margin: 0.4rem 0 0;
    line-height: 1.4;
  }

  .progress-bar-container {
    margin-top: 0.75rem;
    height: 6px;
    background: #dcfce7;
    border-radius: 999px;
    overflow: hidden;
  }

  .progress-bar {
    height: 100%;
    background: linear-gradient(90deg, #22c55e, #16a34a);
    border-radius: 999px;
    transition: width 0.3s ease;
  }

  .progress-text {
    font-size: 0.72rem;
    color: #16a34a;
    font-weight: 600;
    margin: 0.3rem 0 0;
    text-align: right;
  }

  .checklist-actions-bar {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 0.5rem;
    margin-bottom: 0.75rem;
  }

  .checklist-right-actions {
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

  .btn-sm {
    font-size: 0.75rem;
    padding: 0.35rem 0.7rem;
  }

  .btn-primary {
    background: #16a34a;
    color: white;
  }

  .btn-primary:hover {
    background: #15803d;
  }

  .btn-primary:disabled {
    background: #86efac;
    cursor: not-allowed;
  }

  .btn-ghost {
    background: transparent;
    color: #16a34a;
    border: 1px solid #bbf7d0;
  }

  .btn-ghost:hover {
    background: white;
  }

  .btn-danger:hover {
    color: #dc2626;
    border-color: #fecaca;
    background: #fff5f5;
  }

  .add-form {
    background: white;
    border: 1px solid #bbf7d0;
    border-radius: 0.75rem;
    padding: 1rem;
    margin-bottom: 1rem;
  }

  .form-row {
    display: grid;
    grid-template-columns: auto 1fr;
    gap: 0.75rem;
    margin-bottom: 0.75rem;
  }

  .form-group {
    display: flex;
    flex-direction: column;
    gap: 0.3rem;
  }

  .form-group-grow {
    min-width: 0;
  }

  .form-group label {
    font-size: 0.72rem;
    font-weight: 600;
    color: #475569;
    text-transform: uppercase;
    letter-spacing: 0.03em;
  }

  .form-group select,
  .form-group input {
    font-size: 0.85rem;
    padding: 0.5rem 0.65rem;
    border: 1px solid #d1d5db;
    border-radius: 0.4rem;
    background: #fafff5;
    color: #334155;
    font-family: inherit;
    transition: border-color 0.15s;
  }

  .form-group select:focus,
  .form-group input:focus {
    outline: none;
    border-color: #16a34a;
    box-shadow: 0 0 0 2px rgba(22, 163, 74, 0.1);
  }

  .categories-list {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }

  .category-section {
    background: white;
    border: 1px solid #e5e7eb;
    border-radius: 0.6rem;
    overflow: hidden;
    transition: border-color 0.2s;
  }

  .category-section.category-done {
    border-color: #86efac;
    background: #f0fdf4;
  }

  .category-header {
    display: flex;
    align-items: center;
    justify-content: space-between;
    width: 100%;
    padding: 0.75rem 1rem;
    background: none;
    border: none;
    cursor: pointer;
    font-family: inherit;
    transition: background 0.1s;
  }

  .category-header:hover {
    background: #f8fafc;
  }

  .category-done .category-header:hover {
    background: #ecfdf5;
  }

  .category-left {
    display: flex;
    align-items: center;
    gap: 0.6rem;
  }

  .category-icon {
    font-size: 0.85rem;
    color: #16a34a;
    width: 1.2rem;
    text-align: center;
  }

  .category-name {
    font-size: 0.85rem;
    font-weight: 700;
    color: #1e293b;
  }

  .category-count {
    font-size: 0.7rem;
    font-weight: 600;
    color: #64748b;
    background: #f1f5f9;
    padding: 0.1rem 0.45rem;
    border-radius: 999px;
  }

  .category-count.count-done {
    color: #16a34a;
    background: #dcfce7;
  }

  .category-toggle {
    font-size: 0.65rem;
    color: #94a3b8;
  }

  .category-items {
    padding: 0 0.5rem 0.5rem;
  }

  .pack-item {
    display: flex;
    align-items: center;
    gap: 0.6rem;
    padding: 0.45rem 0.5rem;
    border-radius: 0.35rem;
    cursor: pointer;
    transition: background 0.1s;
    position: relative;
  }

  .pack-item:hover {
    background: #f8fafc;
  }

  .pack-item-checked {
    opacity: 0.55;
  }

  .pack-checkbox {
    width: 1.1rem;
    height: 1.1rem;
    accent-color: #16a34a;
    cursor: pointer;
    flex-shrink: 0;
  }

  .pack-text {
    font-size: 0.82rem;
    color: #334155;
    line-height: 1.4;
    flex: 1;
  }

  .pack-item-checked .pack-text {
    text-decoration: line-through;
    color: #94a3b8;
  }

  .pack-remove {
    background: none;
    border: none;
    color: #cbd5e1;
    cursor: pointer;
    font-size: 0.65rem;
    padding: 0.2rem;
    border-radius: 0.2rem;
    transition: all 0.15s;
    flex-shrink: 0;
  }

  .pack-remove:hover {
    color: #ef4444;
    background: #fef2f2;
  }

  @media (max-width: 480px) {
    .form-row {
      grid-template-columns: 1fr;
    }
    .checklist-actions-bar {
      flex-wrap: wrap;
    }
  }
</style>
