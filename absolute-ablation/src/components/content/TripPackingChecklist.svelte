<script lang="ts">
  import PackingChecklist from './PackingChecklist.svelte';

  interface CategoryDef {
    name: string;
    icon: string;
    items: string[];
  }

  interface Props {
    storageKey?: string;
    /** Extra items to append to specific base categories (by name). */
    extraItems?: Record<string, string[]>;
    /** Fully custom categories to add after the base ones. */
    extraCategories?: CategoryDef[];
  }

  let {
    storageKey = 'packing-checklist',
    extraItems = {},
    extraCategories = [],
  }: Props = $props();

  // ─── Shared base categories for family road trips ───

  const baseCategories: CategoryDef[] = [
    {
      name: 'Clothing',
      icon: 'fa-tshirt',
      items: [
        'Warm fleece/sweater — everyone',
        'Rain jackets — adults',
        'Rain jackets — kids',
        'Comfortable walking shoes',
        'Extra socks',
      ],
    },
    {
      name: 'Baby / Toddler',
      icon: 'fa-baby',
      items: [
        'Car seat',
        'Compact folding stroller',
        'Baby carrier (for stairs/caves/mountains)',
        'Nappies (buy in bulk before departure)',
        'Baby food / pouches',
        'Milk / formula + bottles',
        'Baby monitor',
        'Baby paracetamol',
        'Bibs, muslins, wipes',
        'Changes of clothes (x3 minimum)',
      ],
    },
    {
      name: 'Older Kids',
      icon: 'fa-child',
      items: [
        'Car seat',
        'Tablet + charger (download shows offline)',
        'Books and small toys for the car',
        'Snacks + water bottle',
        'Rain boots',
        'Colouring book + pencils',
      ],
    },
    {
      name: 'Travel & Documents',
      icon: 'fa-passport',
      items: [
        'Passports / IDs — everyone',
        'Health insurance cards / EHIC',
        'Booking confirmations (printed + phone)',
        'Cash — EUR',
        'Phone + car chargers',
        'Offline Google Maps downloaded',
        'Travel insurance documents',
      ],
    },
    {
      name: 'Comfort & Misc',
      icon: 'fa-first-aid',
      items: [
        'First aid kit',
        'Sunscreen — high SPF for kids',
        'Reusable water bottles',
        'Picnic blanket',
        'Camera / phone',
        'Umbrella',
        'Portable phone charger / power bank',
        'Plastic bags (wet clothes, nappies)',
        'Car snack bag',
        'Hand sanitiser',
      ],
    },
  ];

  // Merge base categories with any extra items passed via props
  let mergedCategories = $derived([
    ...baseCategories.map((cat) => {
      const extras = extraItems[cat.name];
      if (extras && extras.length > 0) {
        return { ...cat, items: [...cat.items, ...extras] };
      }
      return cat;
    }),
    ...extraCategories,
  ]);
</script>

<PackingChecklist storageKey={storageKey} categories={mergedCategories} />
