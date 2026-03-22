# Content Authoring Guide

Comprehensive guide for writing blog posts and travel articles on this Astro 6 + Svelte 5 + MDX site.

All content components live in `src/components/content/` and work in **both** blog and travel posts.

---

## 1. Quick Start

### Blog post

Create a new `.mdx` file in `src/content/blog/`:

```
src/content/blog/my-new-post.mdx
```

Frontmatter:

```yaml
---
title: "Your Post Title"
description: "A one- or two-sentence summary for SEO and card previews."
pubDate: 2026-03-11
tags: ["Topic A", "Topic B"]
readingTime: "8 min read"
---
```

### Travel post

Create a new `.mdx` file in `src/content/travel/`:

```
src/content/travel/my-trip.mdx
```

Frontmatter:

```yaml
---
title: "Our Trip to Somewhere"
description: "A family road trip through..."
pubDate: 2025-04-24
location: "Netherlands → Switzerland"
tags: ["Road Trip", "Family Travel"]
coverImage: "/images/trip-cover.jpg"
readingTime: "25 min read"
---
```

### Minimal working example

```mdx
---
title: "Your Post Title"
description: "A one- or two-sentence summary."
pubDate: 2026-03-11
tags: ["Topic"]
readingTime: "8 min read"
---

import Callout from '../../components/content/Callout.svelte';

<div class="prose-content">

Your prose goes here. Wrap long-form paragraphs in `<div class="prose-content">`
to get the serif reading font (Merriweather) and proper paragraph spacing.

</div>

<Callout type="insight">
  <p>This is a key takeaway.</p>
</Callout>
```

That is a valid, publishable post. Everything below adds richness.

---

## 2. Frontmatter Schemas

Defined in `src/content.config.ts`. Validated by Zod at build time — invalid frontmatter causes a build error.

### Blog schema

| Field | Type | Required | Default | Notes |
|-------|------|----------|---------|-------|
| `title` | `string` | Yes | — | Post title, used in `<title>` and cards |
| `description` | `string` | Yes | — | SEO meta description and card preview text |
| `pubDate` | `date` | Yes | — | Publication date. Accepts `YYYY-MM-DD` (coerced to `Date`) |
| `updatedDate` | `date` | No | — | Last-modified date, shown if present |
| `tags` | `string[]` | No | `[]` | Category/topic tags for filtering |
| `readingTime` | `string` | No | — | Displayed on the post, e.g. `"8 min read"` |
| `external` | `string` | No | — | URL if hosted elsewhere (card becomes outbound link) |

### Travel schema

| Field | Type | Required | Default | Notes |
|-------|------|----------|---------|-------|
| `title` | `string` | Yes | — | Trip title |
| `description` | `string` | Yes | — | SEO meta description |
| `pubDate` | `date` | Yes | — | Publication date |
| `updatedDate` | `date` | No | — | Last-modified date |
| `location` | `string` | No | — | Route/destination label |
| `tags` | `string[]` | No | `[]` | Tags for filtering |
| `coverImage` | `string` | No | — | Cover image path |
| `readingTime` | `string` | No | — | Reading time estimate |

---

## 3. Component Reference

All 15 components live in `src/components/content/`. Import them at the top of your MDX file, **after** the frontmatter closing `---`.

```mdx
import ComponentName from '../../components/content/ComponentName.svelte';
```

### Component categories

| Category | Components | `client:load` needed? |
|----------|-----------|----------------------|
| **Static** (build-time render, zero JS shipped) | Callout, TldrBox, SectionHeading, FormulaBox, ExampleCard, ProjectCard, PitfallCard, StepList, StepItem, DataTable, MetricBar, LinkCard | No |
| **Interactive** (browser JS required) | ChartContainer, TravelTips, PackingChecklist | **Yes** |

---

### 3.1 Callout

A highlighted aside for insights, tips, or warnings.

| Prop | Type | Default | Required |
|------|------|---------|----------|
| `type` | `'insight' \| 'tip' \| 'warning'` | `'insight'` | No |
| `title` | `string` | Auto from type (`'Key Insight'`, `'Tip'`, `'Warning'`) | No |
| `icon` | `string` | Auto from type (`fa-lightbulb`, `fa-check`, `fa-triangle-exclamation`) | No |
| children | Snippet | — | Yes |

```mdx
import Callout from '../../components/content/Callout.svelte';

<Callout type="warning" title="Heads Up" icon="fa-fire">
  <p>This is a custom warning with a fire icon.</p>
</Callout>

<!-- Or use defaults — type alone is enough -->
<Callout type="tip">
  <p>Quick tip using default title and icon.</p>
</Callout>
```

---

### 3.2 TldrBox

A summary box at the top of a post. Items are rendered as HTML so you can use `<strong>`, `<em>`, etc.

| Prop | Type | Default | Required |
|------|------|---------|----------|
| `items` | `string[]` | — | Yes |

```mdx
import TldrBox from '../../components/content/TldrBox.svelte';

<TldrBox items={[
  "<strong>First key point.</strong> Supporting detail.",
  "Second point with <em>emphasis</em>.",
  "Third point."
]} />
```

---

### 3.3 SectionHeading

A styled `<h2>` with a colored icon badge. Use it to break a post into major sections.

| Prop | Type | Default | Required |
|------|------|---------|----------|
| `icon` | `string` | — | Yes |
| `color` | `string` | — | Yes |
| children | Snippet | — | Yes |

Available colors: `red`, `blue`, `amber`, `purple`, `indigo`, `emerald`, `gray`.

Icons use [Font Awesome](https://fontawesome.com/icons) class names (without the `fas` prefix — it is added automatically).

```mdx
import SectionHeading from '../../components/content/SectionHeading.svelte';

<SectionHeading icon="fa-calculator" color="blue">What is WSJF?</SectionHeading>
<SectionHeading icon="fa-mountain" color="emerald">Day 6: Mount Rigi</SectionHeading>
```

---

### 3.4 FormulaBox

A dark-background centered box for formulas or key equations. Accepts an optional caption.

| Prop | Type | Default | Required |
|------|------|---------|----------|
| `caption` | `string` | — | No |
| children | Snippet | — | Yes |

```mdx
import FormulaBox from '../../components/content/FormulaBox.svelte';

<FormulaBox caption="Highest score = build it first">
  <p class="text-2xl font-mono text-white">
    ROI = Revenue / Investment
  </p>
</FormulaBox>
```

The content area uses a monospace font (`JetBrains Mono` / `Fira Code`) on a dark gradient background.

---

### 3.5 ExampleCard

A card with a colored left border for real-world examples or case studies.

| Prop | Type | Default | Required |
|------|------|---------|----------|
| `accent` | `'blue' \| 'amber' \| 'emerald'` | — | Yes |
| `icon` | `string` | — | Yes |
| `title` | `string` | — | Yes |
| children | Snippet | — | Yes |

```mdx
import ExampleCard from '../../components/content/ExampleCard.svelte';

<ExampleCard accent="blue" icon="fa-gavel" title="The compliance deadline">
  <div class="prose-content">
    <p>A fintech startup had a GDPR regulation coming into effect...</p>
  </div>
</ExampleCard>
```

You can nest other components (like `Callout`) inside:

```mdx
<ExampleCard accent="amber" icon="fa-robot" title="The big bet">
  <div class="prose-content">
    <p>The CEO was pushing hard for an AI feature...</p>
  </div>
  <Callout type="insight">
    <p>The AI feature was more valuable in absolute terms, but...</p>
  </Callout>
</ExampleCard>
```

---

### 3.6 ProjectCard

A rich card for comparing projects/options. Shows a letter badge, description, metric bars, job size, and a WSJF score. Optionally marks a winner.

| Prop | Type | Default | Required |
|------|------|---------|----------|
| `letter` | `string` | — | Yes |
| `title` | `string` | — | Yes |
| `description` | `string` | — | Yes |
| `metrics` | `Metric[]` | — | Yes |
| `jobSize` | `string` | — | Yes |
| `wsjfScore` | `number` | — | Yes |
| `winner` | `boolean` | `false` | No |

Where `Metric` is:
```ts
{ label: string; value: string; percentage: number; color: string }
```

Metric `color` accepts named colors: `blue`, `amber`, `emerald`, `red`, `purple`, `indigo` (or any CSS color string).

```mdx
import ProjectCard from '../../components/content/ProjectCard.svelte';

<div class="grid grid-cols-1 md:grid-cols-3 gap-4 my-8">
  <ProjectCard
    letter="A"
    title="AI-powered task summaries"
    description="Auto-summarize tasks. High demand, no deadline."
    metrics={[
      { label: "BV", value: "$15K/mo", percentage: 60, color: "blue" },
      { label: "TS", value: "$0", percentage: 0, color: "amber" },
      { label: "RR", value: "$2K/mo", percentage: 8, color: "emerald" }
    ]}
    jobSize="1,200 hrs"
    wsjfScore={14.2}
  />
  <ProjectCard
    letter="B"
    title="SOC 2 compliance"
    description="Enterprise deals blocked until certified."
    metrics={[
      { label: "BV", value: "$0", percentage: 0, color: "blue" },
      { label: "TS", value: "$5K/mo", percentage: 20, color: "amber" },
      { label: "RR", value: "$25K/mo", percentage: 100, color: "emerald" }
    ]}
    jobSize="800 hrs"
    wsjfScore={37.5}
    winner={true}
  />
</div>
```

---

### 3.7 PitfallCard

A red-tinted warning card for common mistakes or anti-patterns.

| Prop | Type | Default | Required |
|------|------|---------|----------|
| `title` | `string` | — | Yes |
| children | Snippet | — | Yes |

```mdx
import PitfallCard from '../../components/content/PitfallCard.svelte';

<PitfallCard title="Treating the score as gospel">
  <p class="text-sm text-gray-600">
    WSJF is a decision-support tool, not a decision-making tool.
  </p>
</PitfallCard>
```

---

### 3.8 StepList

A wrapper that provides the vertical timeline layout for `StepItem` children.

| Prop | Type | Default | Required |
|------|------|---------|----------|
| children | Snippet | — | Yes |

No props of its own — it only provides layout context. Always use with `StepItem`.

---

### 3.9 StepItem

A numbered step within a `StepList`. Renders a blue numbered circle on a vertical timeline.

| Prop | Type | Default | Required |
|------|------|---------|----------|
| `number` | `number` | — | Yes |
| `title` | `string` | — | Yes |
| children | Snippet | — | Yes |

```mdx
import StepList from '../../components/content/StepList.svelte';
import StepItem from '../../components/content/StepItem.svelte';

<StepList>
  <StepItem number={1} title="Get the right people in the room">
    <p>You need someone who understands business impact...</p>
  </StepItem>
  <StepItem number={2} title="List 3-7 initiatives">
    <p>More than that and the exercise becomes unwieldy.</p>
  </StepItem>
  <StepItem number={3} title="Score each component">
    <p>Use dollar values or a Fibonacci-like relative scale.</p>
  </StepItem>
</StepList>
```

---

### 3.10 DataTable

A responsive table with a dark header, optional row highlighting, and the last cell of the highlighted row bolded.

| Prop | Type | Default | Required |
|------|------|---------|----------|
| `headers` | `string[]` | — | Yes |
| `rows` | `(string \| number)[][]` | — | Yes |
| `highlightRow` | `number` | — | No |

`highlightRow` is a **zero-based** index.

```mdx
import DataTable from '../../components/content/DataTable.svelte';

<DataTable
  headers={["Project", "Cost of Delay", "Job Size", "WSJF"]}
  rows={[
    ["A: AI summaries", "$17,000/mo", "1,200 hrs", "14.2"],
    ["B: SOC 2 compliance", "$30,000/mo", "800 hrs", "37.5"],
    ["C: Dashboard refresh", "$4,000/mo", "400 hrs", "10.0"]
  ]}
  highlightRow={1}
/>
```

---

### 3.11 MetricBar

A standalone horizontal bar for showing a single metric. Useful outside of `ProjectCard`.

| Prop | Type | Default | Required |
|------|------|---------|----------|
| `label` | `string` | — | Yes |
| `value` | `string` | — | Yes |
| `percentage` | `number` | — | Yes |
| `color` | `string` | — | Yes |

Named colors: `blue`, `amber`, `emerald`, `red`, `purple`, `indigo` (or any CSS color string).

```mdx
import MetricBar from '../../components/content/MetricBar.svelte';

<MetricBar label="BV" value="$15K/mo" percentage={60} color="blue" />
<MetricBar label="TS" value="$5K/mo" percentage={20} color="amber" />
```

---

### 3.12 LinkCard

A clickable card that links to an external resource. Opens in a new tab.

| Prop | Type | Default | Required |
|------|------|---------|----------|
| `href` | `string` | — | Yes |
| `icon` | `string` | `'fa-arrow-right'` | No |
| children | Snippet | — | Yes |

```mdx
import LinkCard from '../../components/content/LinkCard.svelte';

<LinkCard href="https://example.com/article" icon="fa-external-link-alt">
  Related Article Title
</LinkCard>

<!-- Group multiple links -->
<div class="flex flex-col sm:flex-row gap-3">
  <LinkCard href="https://example.com/docs" icon="fa-book">
    Official Documentation
  </LinkCard>
  <LinkCard href="https://example.com/repo" icon="fa-code">
    Source Code
  </LinkCard>
</div>
```

---

### 3.13 ChartContainer (interactive)

An interactive Chart.js chart. **Requires `client:load`** because it runs JavaScript in the browser to render a `<canvas>`.

| Prop | Type | Default | Required |
|------|------|---------|----------|
| `id` | `string` | — | Yes |
| `chartConfig` | `object` | — | Yes |

`chartConfig` is a standard [Chart.js configuration object](https://www.chartjs.org/docs/latest/configuration/) (`{ type, data, options }`). Chart.js is loaded from CDN automatically on first use.

```mdx
import ChartContainer from '../../components/content/ChartContainer.svelte';

<ChartContainer client:load id="myBarChart" chartConfig={{
  type: 'bar',
  data: {
    labels: ['Q1', 'Q2', 'Q3'],
    datasets: [{
      label: 'Revenue',
      data: [10000, 25000, 18000],
      backgroundColor: '#3b82f6',
      borderRadius: 4
    }]
  },
  options: {
    responsive: true,
    maintainAspectRatio: false,
    plugins: { legend: { display: false } }
  }
}} />
```

> **Important:** Always include `client:load` on the `<ChartContainer>` tag. Without it, the canvas will be blank.

---

### 3.14 TravelTips (interactive)

A personal travel notes/tips pad. Users can add, filter, export, and delete tips. All data persists in `localStorage` — private to the reader's browser. **Requires `client:load`.**

**Theme:** Indigo/purple gradient.

| Prop | Type | Default | Required |
|------|------|---------|----------|
| `storageKey` | `string` | `'travel-tips-ch-2025'` | No |
| `destinations` | `string[]` | `[]` | No |

#### How it works

- **Add tips** with a destination, category, and free-text note.
- **8 built-in categories:** General, Food & Drink, Transport, Accommodation, Activity, Kids, Accessibility, Budget.
- **Filter** by destination (tab buttons appear once tips exist).
- **Export** all tips as a `.txt` file.
- **Clear all** with confirmation dialog.
- **Keyboard shortcut:** `Cmd+Enter` in the textarea to save.

#### Props explained

- `storageKey`: A unique localStorage key. Use a different key per trip/post to keep data separate. e.g. `'travel-tips-japan-2026'`.
- `destinations`: Array of destination names that appear in the "Destination" dropdown. The component also adds a "General" option automatically.

```mdx
import TravelTips from '../../components/content/TravelTips.svelte';

<TravelTips
  client:load
  storageKey="travel-tips-rotterdam-switzerland-2025"
  destinations={[
    "Rotterdam",
    "Cologne",
    "Koblenz",
    "Lucerne",
    "Weggis",
    "Vitznau",
    "Mount Rigi",
    "Mount Pilatus",
    "Kaiserstuhl",
    "Königswinter"
  ]}
/>
```

#### Use cases

- **Travel posts:** Let readers save their own tips while reading your itinerary.
- **Blog posts:** Could be repurposed as a general note-taking widget for any topic (e.g. "Your Reading Notes") by customising `destinations` to be topic categories.

---

### 3.15 PackingChecklist (interactive)

An interactive packing checklist with per-category grouping, progress tracking, and localStorage persistence. Users tick items off as they pack. **Requires `client:load`.**

**Theme:** Green gradient.

| Prop | Type | Default | Required |
|------|------|---------|----------|
| `storageKey` | `string` | `'packing-checklist'` | No |
| `categories` | `CategoryDef[]` | `[]` | No |

Where `CategoryDef` is:

```ts
interface CategoryDef {
  name: string;   // Category heading, e.g. "Clothing"
  icon: string;   // Font Awesome icon class, e.g. "fa-tshirt"
  items: string[]; // Pre-populated item names
}
```

#### How it works

- **Pre-populated items** from the `categories` prop. Each item gets a checkbox.
- **Progress bar** shows overall % packed, plus per-category counts (e.g. `3/11`).
- **Collapsible categories** — click the header to expand/collapse.
- **Add custom items** — pick a category, type an item name, hit Enter or click Add. Custom items show a red "x" remove button.
- **Export** the full list as a `.txt` file with `[x]`/`[ ]` markers.
- **Reset** clears all checkmarks and removes custom items (with confirmation).
- **Auto-save** to `localStorage` on every change.
- Categories turn green when all items within them are checked.

#### Props explained

- `storageKey`: Unique localStorage key per checklist. Use a different key per trip. e.g. `'packing-japan-2026'`.
- `categories`: Array of category definitions. Each category has a `name`, Font Awesome `icon`, and array of `items` (strings). Items are rendered as checkboxes in the given order.

```mdx
import PackingChecklist from '../../components/content/PackingChecklist.svelte';

<PackingChecklist
  client:load
  storageKey="packing-checklist-rotterdam-switzerland-2025"
  categories={[
    {
      name: "Clothing",
      icon: "fa-tshirt",
      items: [
        "Rain jackets (all sizes)",
        "Warm fleece layers",
        "Comfortable walking shoes",
        "Sun hats",
        "Swimwear"
      ]
    },
    {
      name: "Baby Essentials",
      icon: "fa-baby",
      items: [
        "Nappies (enough for 2 days, buy more en route)",
        "Baby food pouches",
        "Portable highchair / booster seat",
        "Stroller + rain cover",
        "Calpol / Nurofen"
      ]
    },
    {
      name: "Documents",
      icon: "fa-passport",
      items: [
        "Passports (all 5)",
        "EHIC / GHIC cards",
        "Travel insurance printout",
        "Hotel confirmations",
        "Vignette for Swiss motorways"
      ]
    }
  ]}
/>
```

#### Use cases

- **Travel posts:** Pre-populate with trip-specific packing items. Readers tick them off as they pack.
- **Blog posts:** Could be repurposed as any task checklist (e.g. "Setup Checklist" for a tutorial) by renaming categories to steps.

---

## 4. Composition Patterns

### Wrapping prose in `<div class="prose-content">`

The `.prose-content` class applies:
- Serif font (Merriweather)
- Comfortable `1.85` line height and `1.05rem` font size
- Proper paragraph spacing
- Animated underline links

Wrap any block of running text in it:

```mdx
<div class="prose-content">

Paragraphs here get the serif reading font. **Markdown** still works
inside the div — just make sure to leave blank lines after the opening
tag and before the closing tag.

</div>
```

Bare text outside `.prose-content` uses the site's default sans-serif font (Inter).

### Using `client:load` only on interactive components

Only `ChartContainer`, `TravelTips`, and `PackingChecklist` need `client:load`. All other components are static Svelte that renders at build time — no JavaScript ships to the browser for them. Do **not** add `client:load` to static components; it would add unnecessary JS to the page bundle.

```mdx
<!-- Correct: client:load on interactive components -->
<ChartContainer client:load id="chart1" chartConfig={{...}} />
<TravelTips client:load storageKey="my-trip" destinations={[...]} />
<PackingChecklist client:load storageKey="my-trip" categories={[...]} />

<!-- Correct: no directive on static components -->
<Callout type="tip">
  <p>This renders at build time.</p>
</Callout>
```

### Nesting Callout inside ExampleCard

Components can be nested. A common pattern is adding a lesson/insight callout at the bottom of an example:

```mdx
<ExampleCard accent="blue" icon="fa-gavel" title="The compliance deadline">
  <div class="prose-content">
    <p>A fintech startup had a regulation coming into effect...</p>
  </div>
  <Callout type="insight">
    <p><strong>Lesson:</strong> Unsexy work often has the highest cost of delay.</p>
  </Callout>
</ExampleCard>
```

### Using StepList / StepItem together

`StepItem` must always be a direct child of `StepList`. The timeline connector line is rendered by `StepItem`'s left border, and the last item automatically hides it:

```mdx
<StepList>
  <StepItem number={1} title="First step">
    <p>Details...</p>
  </StepItem>
  <StepItem number={2} title="Second step">
    <p>Details...</p>
  </StepItem>
</StepList>
```

### Combining ProjectCard grid with DataTable

Use a responsive grid of `ProjectCard` components for visual comparison, then follow with a `DataTable` for a scannable summary:

```mdx
<div class="grid grid-cols-1 md:grid-cols-3 gap-4 my-8">
  <ProjectCard letter="A" title="..." description="..." metrics={[...]} jobSize="..." wsjfScore={14.2} />
  <ProjectCard letter="B" title="..." description="..." metrics={[...]} jobSize="..." wsjfScore={37.5} winner={true} />
</div>

<DataTable
  headers={["Project", "Cost of Delay", "Job Size", "WSJF"]}
  rows={[
    ["A: ...", "$17,000/mo", "1,200 hrs", "14.2"],
    ["B: ...", "$30,000/mo", "800 hrs", "37.5"]
  ]}
  highlightRow={1}
/>
```

### Using interactive components together in a travel post

A travel post typically combines static components for the narrative with interactive ones at the bottom:

```mdx
<!-- Static content: itinerary, callouts, data tables -->
<SectionHeading icon="fa-road" color="blue">The Route</SectionHeading>
<div class="prose-content">
  <p>Our drive takes us through three countries...</p>
</div>

<DataTable headers={["Day", "From", "To", "Drive"]} rows={[...]} />

<!-- Interactive: let readers save notes and track packing -->
<TravelTips client:load storageKey="trip-2025" destinations={["City A", "City B"]} />
<PackingChecklist client:load storageKey="packing-2025" categories={[...]} />
```

---

## 5. Creating New Components

### Location

Place new content components in `src/components/content/`. The naming convention is `PascalCase.svelte`.

### Svelte 5 Runes

This project uses Svelte 5. All components **must** use the runes API. Do not use Svelte 4 patterns (`export let`, `$:`, `<slot>`).

| Concept | Svelte 5 Syntax |
|---------|-----------------|
| Props | `let { foo, bar = 'default' }: Props = $props();` |
| Reactive state | `let count = $state(0);` |
| Derived values | `let doubled = $derived(count * 2);` |
| Side effects | `$effect(() => { /* runs when deps change */ });` |
| Slotted content | `children: import('svelte').Snippet` prop + `{@render children()}` |
| Event handlers | `onclick={(e) => { ... }}` (not `on:click`) |
| Event modifiers | Inline: `onclick={(e) => { e.stopPropagation(); ... }}` (not `onclick\|stopPropagation`) |

### Component Template

```svelte
<script lang="ts">
  interface Props {
    label: string;
    variant?: 'primary' | 'secondary';
    children: import('svelte').Snippet;
  }

  let { label, variant = 'primary', children }: Props = $props();

  let isActive = $state(false);
  let cssClass = $derived(variant === 'primary' ? 'btn-primary' : 'btn-secondary');
</script>

<div class="my-component {cssClass}">
  <span class="label">{label}</span>
  <div class="body">
    {@render children()}
  </div>
</div>

<style>
  .my-component {
    /* scoped styles — only apply to this component */
    border-radius: 0.75rem;
    padding: 1.25rem;
    margin: 1rem 0;
  }
</style>
```

### Interactive component template (with localStorage)

```svelte
<script lang="ts">
  interface Props {
    storageKey?: string;
  }

  let { storageKey = 'my-widget' }: Props = $props();
  let data = $state<string[]>([]);

  function load() {
    try {
      const stored = localStorage.getItem(storageKey);
      if (stored) data = JSON.parse(stored);
    } catch { /* ignore */ }
  }

  function save() {
    try {
      localStorage.setItem(storageKey, JSON.stringify(data));
    } catch { /* ignore */ }
  }

  $effect(() => { load(); });
</script>

<!-- Template here -->
<!-- Use in MDX with client:load -->
```

### Guidelines

- Use `<script lang="ts">` for TypeScript in script blocks.
- Prefer **scoped styles** (the `<style>` block at the bottom of the `.svelte` file). They are automatically scoped to the component.
- If a component is purely presentational (no browser interactivity), it does not need `client:load` in MDX — Astro renders it at build time.
- If a component needs browser APIs (`window`, `document`, `localStorage`, `$effect` with DOM access), it **must** have `client:load` when used in MDX.
- **localStorage keys must be unique** across interactive components on the same page. Use descriptive, post-specific keys like `'packing-japan-2026'` or `'travel-tips-iceland-2025'`.

---

## 6. Styling

### Shared Blog Styles

`src/styles/blog-components.css` provides shared classes used across MDX posts:

| Class | Purpose |
|-------|---------|
| `.prose-content` | Serif reading font, line height, paragraph spacing, link animations |
| `.chart-container` | Sizing for Chart.js canvases (580px max, 280px height) |
| `.fade-section` / `.visible` | Intersection-observer fade-in animation |
| `blockquote` | Styled blockquote with blue left border |

This stylesheet is imported by the blog layout — you do not need to import it in your MDX file.

### Tailwind v4

Tailwind CSS v4 utility classes are available everywhere — in MDX content, in Svelte component templates, and in stylesheets. The configuration is in `src/styles/global.css` using `@import "tailwindcss"`.

Common patterns used in posts:

```html
<!-- Responsive grid -->
<div class="grid grid-cols-1 md:grid-cols-3 gap-4 my-8">

<!-- Spacing and typography -->
<p class="text-sm text-gray-600 leading-relaxed mb-3">

<!-- Flex layouts -->
<div class="flex flex-col sm:flex-row gap-3">
```

### Color Tokens

Custom color tokens are defined in `src/styles/global.css` under `@theme`:

| Token | Value | Usage |
|-------|-------|-------|
| `--color-terminal-bg` | `#0a0a0c` | Dark background |
| `--color-terminal-green` | `#4ade80` | Accent green |
| `--color-terminal-surface` | `#1a1a1e` | Card surfaces |
| `--color-sparrow-bg` | `hsl(220, 25%, 6%)` | Site background |
| `--color-sparrow-card` | `hsl(220, 25%, 9%)` | Card background |
| `--color-sparrow-primary` | `hsl(172, 66%, 50%)` | Primary accent (teal) |
| `--color-sparrow-muted` | `hsl(220, 10%, 55%)` | Muted text |
| `--color-sparrow-border` | `hsl(220, 20%, 15%)` | Border color |

Font families available via Tailwind:

| Class | Font Stack |
|-------|-----------|
| `font-sans` | Inter, system UI |
| `font-serif` | Merriweather, Georgia |
| `font-mono` | Fira Code, monospace |

### Interactive component color themes

| Component | Theme | Primary color |
|-----------|-------|--------------|
| TravelTips | Indigo/purple | `#4f46e5` (indigo-600) |
| PackingChecklist | Green | `#16a34a` (green-600) |
| ChartContainer | Neutral | Inherits from chart config |

When building new interactive components, pick a distinct color theme to make them visually distinguishable on the same page.

---

## Quick Reference: All Imports

Copy this block into a new MDX file and delete the components you do not need:

```mdx
<!-- Static components (no client:load needed) -->
import Callout from '../../components/content/Callout.svelte';
import TldrBox from '../../components/content/TldrBox.svelte';
import SectionHeading from '../../components/content/SectionHeading.svelte';
import FormulaBox from '../../components/content/FormulaBox.svelte';
import ExampleCard from '../../components/content/ExampleCard.svelte';
import ProjectCard from '../../components/content/ProjectCard.svelte';
import PitfallCard from '../../components/content/PitfallCard.svelte';
import StepList from '../../components/content/StepList.svelte';
import StepItem from '../../components/content/StepItem.svelte';
import DataTable from '../../components/content/DataTable.svelte';
import MetricBar from '../../components/content/MetricBar.svelte';
import LinkCard from '../../components/content/LinkCard.svelte';

<!-- Interactive components (MUST use client:load) -->
import ChartContainer from '../../components/content/ChartContainer.svelte';
import TravelTips from '../../components/content/TravelTips.svelte';
import PackingChecklist from '../../components/content/PackingChecklist.svelte';
```
