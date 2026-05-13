<script lang="ts">
  interface Stop {
    name: string;
    lat: number;
    lng: number;
    day?: string;
    isCustom?: boolean;
  }

  interface Props {
    id?: string;
    stops: Stop[];
    zoom?: number;
    height?: number;
    /** localStorage key for user-added stops */
    storageKey?: string;
    /** Allow users to add/remove custom stops */
    editable?: boolean;
  }

  let { id = 'route-map', stops: initialStops, zoom, height = 400, storageKey = 'route-map-custom-stops', editable = true }: Props = $props();

  let mapContainer: HTMLDivElement;
  let mapInstance: any = $state(null);
  let leafletRef: any = $state(null);
  let markersLayer: any = $state(null);
  let routeLine: any = $state(null);

  // Custom stops from localStorage
  let customStops: Stop[] = $state([]);
  let showAddForm = $state(false);
  let newName = $state('');
  let newDay = $state('');
  let insertAfterIndex = $state(-1); // -1 = end, otherwise index to insert after
  let searchQuery = $state('');
  let searchResults: { display_name: string; lat: string; lon: string }[] = $state([]);
  let searching = $state(false);
  let selectedCoords: { lat: number; lng: number } | null = $state(null);
  let clickToPlace = $state(false);
  let searchTimeout: ReturnType<typeof setTimeout> | null = null;

  // Merge initial + custom stops
  let allStops = $derived.by(() => {
    // Rebuild merged list: custom stops are inserted at their stored positions
    const base = initialStops.map(s => ({ ...s, isCustom: false }));
    const custom = customStops.map(s => ({ ...s, isCustom: true }));

    // Custom stops store their insertAfter index relative to the full list
    // We rebuild by splicing them in order
    const merged: Stop[] = [...base];
    for (const cs of custom) {
      // Find the best insertion point — stored as _insertAt
      const idx = Math.min((cs as any)._insertAt ?? merged.length, merged.length);
      merged.splice(idx, 0, cs);
    }
    return merged;
  });

  const LEAFLET_CSS = 'https://unpkg.com/leaflet@1.9.4/dist/leaflet.css';
  const LEAFLET_JS = 'https://unpkg.com/leaflet@1.9.4/dist/leaflet.js';

  function loadLeaflet(): Promise<void> {
    if ((window as any).__leafletLoading) return (window as any).__leafletLoading;
    if ((window as any).L) return Promise.resolve();
    (window as any).__leafletLoading = new Promise<void>((resolve, reject) => {
      const link = document.createElement('link');
      link.rel = 'stylesheet';
      link.href = LEAFLET_CSS;
      document.head.appendChild(link);
      const script = document.createElement('script');
      script.src = LEAFLET_JS;
      script.onload = () => resolve();
      script.onerror = () => reject(new Error('Failed to load Leaflet'));
      document.head.appendChild(script);
    });
    return (window as any).__leafletLoading;
  }

  function makeIcon(L: any, num: number, type: 'start' | 'end' | 'default' | 'custom') {
    const colors = { start: '#2563eb', end: '#2563eb', default: '#374151', custom: '#d97706' };
    const bg = colors[type];
    return L.divIcon({
      className: 'route-map-marker',
      html: `<div style="
        width:28px;height:28px;border-radius:50%;
        background:${bg};color:#fff;font-size:12px;font-weight:700;
        display:flex;align-items:center;justify-content:center;
        border:2px solid #fff;box-shadow:0 2px 6px rgba(0,0,0,0.3);
        ${type === 'custom' ? 'border-color:#fbbf24;' : ''}
      ">${num}</div>`,
      iconSize: [28, 28],
      iconAnchor: [14, 14],
      popupAnchor: [0, -16],
    });
  }

  function loadCustomStops() {
    try {
      const stored = localStorage.getItem(storageKey);
      if (stored) customStops = JSON.parse(stored);
    } catch { /* ignore */ }
  }

  function saveCustomStops() {
    try {
      localStorage.setItem(storageKey, JSON.stringify(customStops));
    } catch { /* ignore */ }
  }

  function renderMap() {
    const L = leafletRef;
    if (!L || !mapInstance) return;

    // Clear existing markers and line
    if (markersLayer) markersLayer.clearLayers();
    if (routeLine) mapInstance.removeLayer(routeLine);

    const group = L.layerGroup().addTo(mapInstance);
    markersLayer = group;

    const coords: [number, number][] = [];

    allStops.forEach((stop, i) => {
      const latlng: [number, number] = [stop.lat, stop.lng];
      coords.push(latlng);

      const type = stop.isCustom ? 'custom'
        : (i === 0 || i === allStops.length - 1) ? 'start'
        : 'default';

      const marker = L.marker(latlng, { icon: makeIcon(L, i + 1, type) }).addTo(group);

      let popupHtml = `<strong>${stop.name}</strong>`;
      if (stop.day) popupHtml += `<br/><span style="font-size:11px;color:#6b7280">${stop.day}</span>`;
      if (stop.isCustom) {
        popupHtml += `<br/><button onclick="window.__routeMapRemove && window.__routeMapRemove('${stop.name}', ${stop.lat}, ${stop.lng})" style="
          margin-top:6px;padding:2px 8px;font-size:11px;
          background:#fee2e2;color:#b91c1c;border:1px solid #fca5a5;
          border-radius:4px;cursor:pointer;
        ">Remove stop</button>`;
      }
      marker.bindPopup(popupHtml);
    });

    if (coords.length > 1) {
      routeLine = L.polyline(coords, {
        color: '#3b82f6',
        weight: 3,
        opacity: 0.7,
        dashArray: '8 6',
      }).addTo(mapInstance);
    }

    // Fit bounds
    if (coords.length > 0) {
      const bounds = L.latLngBounds(coords);
      mapInstance.fitBounds(bounds, { padding: [40, 40] });
    }
  }

  function addStop() {
    if (!newName.trim() || !selectedCoords) return;

    const stop: Stop & { _insertAt?: number } = {
      name: newName.trim(),
      lat: selectedCoords.lat,
      lng: selectedCoords.lng,
      day: newDay.trim() || undefined,
      isCustom: true,
      _insertAt: insertAfterIndex === -1 ? allStops.length : insertAfterIndex + 1,
    };

    customStops = [...customStops, stop as any];
    saveCustomStops();
    resetForm();
    // Re-render will happen via $effect watching allStops
  }

  function removeCustomStop(name: string, lat: number, lng: number) {
    customStops = customStops.filter(s => !(s.name === name && s.lat === lat && s.lng === lng));
    saveCustomStops();
  }

  // Expose remove function globally for popup buttons
  $effect(() => {
    (window as any).__routeMapRemove = removeCustomStop;
    return () => { delete (window as any).__routeMapRemove; };
  });

  function resetForm() {
    showAddForm = false;
    newName = '';
    newDay = '';
    selectedCoords = null;
    searchQuery = '';
    searchResults = [];
    insertAfterIndex = -1;
    clickToPlace = false;
  }

  async function searchPlace(query: string) {
    if (query.length < 3) { searchResults = []; return; }
    searching = true;
    try {
      const res = await fetch(
        `https://nominatim.openstreetmap.org/search?format=json&q=${encodeURIComponent(query)}&limit=5&addressdetails=0`,
        { headers: { 'Accept-Language': 'en' } }
      );
      searchResults = await res.json();
    } catch {
      searchResults = [];
    }
    searching = false;
  }

  function onSearchInput() {
    if (searchTimeout) clearTimeout(searchTimeout);
    searchTimeout = setTimeout(() => searchPlace(searchQuery), 400);
  }

  function selectSearchResult(result: { display_name: string; lat: string; lon: string }) {
    selectedCoords = { lat: parseFloat(result.lat), lng: parseFloat(result.lon) };
    newName = newName || result.display_name.split(',')[0];
    searchQuery = result.display_name.split(',').slice(0, 2).join(',');
    searchResults = [];
  }

  function enableClickToPlace() {
    clickToPlace = true;
    if (mapInstance) {
      mapInstance.once('click', (e: any) => {
        selectedCoords = { lat: e.latlng.lat, lng: e.latlng.lng };
        clickToPlace = false;
      });
    }
  }

  // Initialize map
  $effect(() => {
    if (!mapContainer) return;
    let destroyed = false;

    loadLeaflet().then(() => {
      if (destroyed) return;
      const L = (window as any).L;
      leafletRef = L;

      if (mapInstance) mapInstance.remove();

      const map = L.map(mapContainer, {
        scrollWheelZoom: false,
        attributionControl: true,
      });

      L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a>',
        maxZoom: 18,
      }).addTo(map);

      mapInstance = map;
      loadCustomStops();
      renderMap();
    }).catch(e => console.error('[RouteMap] Failed to load Leaflet:', e));

    return () => {
      destroyed = true;
      if (mapInstance) { mapInstance.remove(); mapInstance = null; }
    };
  });

  // Re-render when stops change
  $effect(() => {
    if (leafletRef && mapInstance) {
      // Touch allStops to track dependency
      const _ = allStops.length;
      renderMap();
    }
  });
</script>

<div class="my-6">
  <!-- Map -->
  <div
    {id}
    bind:this={mapContainer}
    class="w-full rounded-t-xl overflow-hidden border border-gray-200 shadow-sm"
    class:rounded-b-xl={!editable}
    style="height: {height}px; position: relative; z-index: 0;"
  >
    {#if clickToPlace}
      <div style="
        position:absolute;top:0;left:0;right:0;
        background:rgba(217,119,6,0.9);color:#fff;
        text-align:center;padding:8px;font-size:13px;font-weight:600;
        z-index:1000;pointer-events:none;
      ">
        Click on the map to place your stop
      </div>
    {/if}
  </div>

  {#if editable}
    <!-- Stop list + controls -->
    <div class="border border-t-0 border-gray-200 rounded-b-xl bg-gray-50 px-4 py-3">
      <!-- Compact stop list -->
      <div class="flex flex-wrap gap-1.5 items-center mb-3">
        {#each allStops as stop, i}
          <span class="inline-flex items-center gap-1 text-xs px-2 py-1 rounded-full font-medium {stop.isCustom ? 'bg-amber-100 text-amber-800 border border-amber-200' : 'bg-gray-200 text-gray-700'}">
            <span class="font-bold">{i + 1}</span>
            {stop.name.length > 20 ? stop.name.slice(0, 18) + '…' : stop.name}
            {#if stop.isCustom}
              <button
                onclick={() => removeCustomStop(stop.name, stop.lat, stop.lng)}
                class="ml-0.5 text-amber-600 hover:text-red-600 font-bold"
                title="Remove stop"
              >&times;</button>
            {/if}
          </span>
          {#if i < allStops.length - 1}
            <span class="text-gray-400 text-xs">→</span>
          {/if}
        {/each}
      </div>

      {#if !showAddForm}
        <button
          onclick={() => showAddForm = true}
          class="text-xs font-semibold text-blue-600 hover:text-blue-800 bg-blue-50 hover:bg-blue-100 border border-blue-200 rounded-lg px-3 py-1.5 transition-colors cursor-pointer"
        >
          + Add a stop
        </button>
      {:else}
        <!-- Add stop form -->
        <div class="bg-white border border-gray-200 rounded-lg p-3 space-y-3">
          <div class="flex items-center justify-between">
            <span class="text-xs font-semibold text-gray-700">Add a custom stop</span>
            <button onclick={resetForm} class="text-xs text-gray-400 hover:text-gray-600 cursor-pointer">&times; Cancel</button>
          </div>

          <!-- Search location -->
          <div>
            <label class="block text-xs font-medium text-gray-600 mb-1">Search location</label>
            <div class="flex gap-2">
              <div class="relative flex-1">
                <input
                  type="text"
                  bind:value={searchQuery}
                  oninput={onSearchInput}
                  placeholder="e.g. Interlaken, Bern, Zürich..."
                  class="w-full text-sm border border-gray-300 rounded-md px-3 py-1.5 focus:ring-1 focus:ring-blue-400 focus:border-blue-400 outline-none"
                />
                {#if searching}
                  <span class="absolute right-2 top-1/2 -translate-y-1/2 text-xs text-gray-400">...</span>
                {/if}
                {#if searchResults.length > 0}
                  <div class="absolute z-50 mt-1 w-full bg-white border border-gray-200 rounded-lg shadow-lg max-h-40 overflow-y-auto">
                    {#each searchResults as result}
                      <button
                        onclick={() => selectSearchResult(result)}
                        class="block w-full text-left px-3 py-2 text-xs text-gray-700 hover:bg-blue-50 border-b border-gray-100 last:border-0 cursor-pointer"
                      >
                        {result.display_name.length > 60 ? result.display_name.slice(0, 58) + '…' : result.display_name}
                      </button>
                    {/each}
                  </div>
                {/if}
              </div>
              <button
                onclick={enableClickToPlace}
                class="text-xs px-2 py-1.5 border rounded-md whitespace-nowrap cursor-pointer {clickToPlace ? 'bg-amber-100 border-amber-300 text-amber-700' : 'border-gray-300 text-gray-600 hover:bg-gray-100'}"
                title="Click on the map to place"
              >
                <i class="fas fa-map-pin"></i> Pin on map
              </button>
            </div>
            {#if selectedCoords}
              <p class="text-xs text-green-600 mt-1">
                Location set: {selectedCoords.lat.toFixed(4)}, {selectedCoords.lng.toFixed(4)}
              </p>
            {/if}
          </div>

          <!-- Name + Day -->
          <div class="grid grid-cols-2 gap-2">
            <div>
              <label class="block text-xs font-medium text-gray-600 mb-1">Stop name</label>
              <input
                type="text"
                bind:value={newName}
                placeholder="e.g. Interlaken"
                class="w-full text-sm border border-gray-300 rounded-md px-3 py-1.5 focus:ring-1 focus:ring-blue-400 focus:border-blue-400 outline-none"
              />
            </div>
            <div>
              <label class="block text-xs font-medium text-gray-600 mb-1">Label (optional)</label>
              <input
                type="text"
                bind:value={newDay}
                placeholder="e.g. Day 4 — detour"
                class="w-full text-sm border border-gray-300 rounded-md px-3 py-1.5 focus:ring-1 focus:ring-blue-400 focus:border-blue-400 outline-none"
              />
            </div>
          </div>

          <!-- Insert position -->
          <div>
            <label class="block text-xs font-medium text-gray-600 mb-1">Insert after</label>
            <select
              bind:value={insertAfterIndex}
              class="w-full text-sm border border-gray-300 rounded-md px-3 py-1.5 bg-white focus:ring-1 focus:ring-blue-400 outline-none"
            >
              {#each allStops as stop, i}
                <option value={i}>
                  {i + 1}. {stop.name.length > 30 ? stop.name.slice(0, 28) + '…' : stop.name}
                </option>
              {/each}
              <option value={-1}>At the end</option>
            </select>
          </div>

          <!-- Submit -->
          <div class="flex gap-2">
            <button
              onclick={addStop}
              disabled={!newName.trim() || !selectedCoords}
              class="text-xs font-semibold px-4 py-1.5 rounded-md transition-colors cursor-pointer
                {newName.trim() && selectedCoords
                  ? 'bg-blue-600 text-white hover:bg-blue-700'
                  : 'bg-gray-200 text-gray-400 cursor-not-allowed'}"
            >
              Add to route
            </button>
            <button onclick={resetForm} class="text-xs text-gray-500 hover:text-gray-700 px-3 py-1.5 cursor-pointer">Cancel</button>
          </div>
        </div>
      {/if}

      {#if customStops.length > 0}
        <p class="text-xs text-gray-400 mt-2">
          {customStops.length} custom stop{customStops.length === 1 ? '' : 's'} — saved in your browser.
          <button onclick={() => { customStops = []; saveCustomStops(); }} class="text-red-400 hover:text-red-600 underline cursor-pointer">Clear all</button>
        </p>
      {/if}
    </div>
  {/if}
</div>
