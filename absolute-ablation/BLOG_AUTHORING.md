# Blog Authoring Guide

Comprehensive guide for adding new blog posts to this Astro 6 + Svelte 5 + MDX site.

---

## 1. Quick Start

Create a new `.mdx` file in `src/content/blog/`:

```
src/content/blog/my-new-post.mdx
```

Every post **must** start with YAML frontmatter:

```mdx
---
title: "Your Post Title"
description: "A one- or two-sentence summary for SEO and card previews."
pubDate: 2026-03-11
tags: ["Topic A", "Topic B"]
readingTime: "8 min read"
---

import Callout from '../../components/blog/Callout.svelte';

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

## 2. Available Components Reference

All 13 blog components live in `src/components/blog/`. Import them at the top of your MDX file, **after** the frontmatter closing `---`.

```mdx
import ComponentName from '../../components/blog/ComponentName.svelte';
```

---

### 2.1 Callout

A highlighted aside for insights, tips, or warnings.

| Prop | Type | Default | Required |
|------|------|---------|----------|
| `type` | `'insight' \| 'tip' \| 'warning'` | `'insight'` | No |
| `title` | `string` | Auto from type (`'Key Insight'`, `'Tip'`, `'Warning'`) | No |
| `icon` | `string` | Auto from type (`fa-lightbulb`, `fa-check`, `fa-triangle-exclamation`) | No |
| children | Snippet | — | Yes |

```mdx
import Callout from '../../components/blog/Callout.svelte';

<Callout type="warning" title="Heads Up" icon="fa-fire">
  <p>This is a custom warning with a fire icon.</p>
</Callout>

<!-- Or use defaults — type alone is enough -->
<Callout type="tip">
  <p>Quick tip using default title and icon.</p>
</Callout>
```

---

### 2.2 TldrBox

A summary box at the top of a post. Items are rendered as HTML so you can use `<strong>`, `<em>`, etc.

| Prop | Type | Default | Required |
|------|------|---------|----------|
| `items` | `string[]` | — | Yes |

```mdx
import TldrBox from '../../components/blog/TldrBox.svelte';

<TldrBox items={[
  "<strong>First key point.</strong> Supporting detail.",
  "Second point with <em>emphasis</em>.",
  "Third point."
]} />
```

---

### 2.3 SectionHeading

A styled `<h2>` with a colored icon badge. Use it to break a post into major sections.

| Prop | Type | Default | Required |
|------|------|---------|----------|
| `icon` | `string` | — | Yes |
| `color` | `string` | — | Yes |
| children | Snippet | — | Yes |

Available colors: `red`, `blue`, `amber`, `purple`, `indigo`, `emerald`, `gray`.

Icons use [Font Awesome](https://fontawesome.com/icons) class names (without the `fas` prefix — it is added automatically).

```mdx
import SectionHeading from '../../components/blog/SectionHeading.svelte';

<SectionHeading icon="fa-calculator" color="blue">What is WSJF?</SectionHeading>
<SectionHeading icon="fa-triangle-exclamation" color="red">Where It Goes Wrong</SectionHeading>
```

---

### 2.4 FormulaBox

A dark-background centered box for formulas or key equations. Accepts an optional caption.

| Prop | Type | Default | Required |
|------|------|---------|----------|
| `caption` | `string` | — | No |
| children | Snippet | — | Yes |

```mdx
import FormulaBox from '../../components/blog/FormulaBox.svelte';

<FormulaBox caption="Highest score = build it first">
  <p class="text-2xl font-mono text-white">
    ROI = Revenue / Investment
  </p>
</FormulaBox>
```

The content area uses a monospace font (`JetBrains Mono` / `Fira Code`) on a dark gradient background.

---

### 2.5 ExampleCard

A card with a colored left border for real-world examples or case studies.

| Prop | Type | Default | Required |
|------|------|---------|----------|
| `accent` | `'blue' \| 'amber' \| 'emerald'` | — | Yes |
| `icon` | `string` | — | Yes |
| `title` | `string` | — | Yes |
| children | Snippet | — | Yes |

```mdx
import ExampleCard from '../../components/blog/ExampleCard.svelte';

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

### 2.6 ProjectCard

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
import ProjectCard from '../../components/blog/ProjectCard.svelte';

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

### 2.7 PitfallCard

A red-tinted warning card for common mistakes or anti-patterns.

| Prop | Type | Default | Required |
|------|------|---------|----------|
| `title` | `string` | — | Yes |
| children | Snippet | — | Yes |

```mdx
import PitfallCard from '../../components/blog/PitfallCard.svelte';

<PitfallCard title="Treating the score as gospel">
  <p class="text-sm text-gray-600">
    WSJF is a decision-support tool, not a decision-making tool.
  </p>
</PitfallCard>
```

---

### 2.8 StepList

A wrapper that provides the vertical timeline layout for `StepItem` children.

| Prop | Type | Default | Required |
|------|------|---------|----------|
| children | Snippet | — | Yes |

No props of its own — it only provides layout context. Always use with `StepItem`.

---

### 2.9 StepItem

A numbered step within a `StepList`. Renders a blue numbered circle on a vertical timeline.

| Prop | Type | Default | Required |
|------|------|---------|----------|
| `number` | `number` | — | Yes |
| `title` | `string` | — | Yes |
| children | Snippet | — | Yes |

```mdx
import StepList from '../../components/blog/StepList.svelte';
import StepItem from '../../components/blog/StepItem.svelte';

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

### 2.10 DataTable

A responsive table with a dark header, optional row highlighting, and the last cell of the highlighted row bolded.

| Prop | Type | Default | Required |
|------|------|---------|----------|
| `headers` | `string[]` | — | Yes |
| `rows` | `(string \| number)[][]` | — | Yes |
| `highlightRow` | `number` | — | No |

`highlightRow` is a **zero-based** index.

```mdx
import DataTable from '../../components/blog/DataTable.svelte';

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

### 2.11 MetricBar

A standalone horizontal bar for showing a single metric. Useful outside of `ProjectCard`.

| Prop | Type | Default | Required |
|------|------|---------|----------|
| `label` | `string` | — | Yes |
| `value` | `string` | — | Yes |
| `percentage` | `number` | — | Yes |
| `color` | `string` | — | Yes |

Named colors: `blue`, `amber`, `emerald`, `red`, `purple`, `indigo` (or any CSS color string).

```mdx
import MetricBar from '../../components/blog/MetricBar.svelte';

<MetricBar label="BV" value="$15K/mo" percentage={60} color="blue" />
<MetricBar label="TS" value="$5K/mo" percentage={20} color="amber" />
```

---

### 2.12 ChartContainer

An interactive Chart.js chart. **This is the only component that requires `client:load`** because it runs JavaScript in the browser to render a `<canvas>`.

| Prop | Type | Default | Required |
|------|------|---------|----------|
| `id` | `string` | — | Yes |
| `chartConfig` | `object` | — | Yes |

`chartConfig` is a standard [Chart.js configuration object](https://www.chartjs.org/docs/latest/configuration/) (`{ type, data, options }`). Chart.js is loaded from CDN automatically on first use.

```mdx
import ChartContainer from '../../components/blog/ChartContainer.svelte';

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

> **Important:** Always include `client:load` on the `<ChartContainer>` tag. Without it, the component renders server-side only and the chart canvas will be blank.

---

### 2.13 LinkCard

A clickable card that links to an external resource. Opens in a new tab.

| Prop | Type | Default | Required |
|------|------|---------|----------|
| `href` | `string` | — | Yes |
| `icon` | `string` | `'fa-arrow-right'` | No |
| children | Snippet | — | Yes |

```mdx
import LinkCard from '../../components/blog/LinkCard.svelte';

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

## 3. Frontmatter Schema

Defined in `src/content.config.ts`. Validated by Zod at build time — invalid frontmatter will cause a build error.

| Field | Type | Required | Default | Notes |
|-------|------|----------|---------|-------|
| `title` | `string` | Yes | — | Post title, used in `<title>` and cards |
| `description` | `string` | Yes | — | SEO meta description and card preview text |
| `pubDate` | `date` | Yes | — | Publication date. Accepts `YYYY-MM-DD` (coerced to `Date`) |
| `updatedDate` | `date` | No | — | Last-modified date, shown if present |
| `tags` | `string[]` | No | `[]` | Category/topic tags for filtering |
| `readingTime` | `string` | No | — | Displayed on the post, e.g. `"8 min read"` |
| `external` | `string` | No | — | URL if the post is hosted elsewhere (turns the card into an outbound link) |

Full example:

```yaml
---
title: "How to Decide What to Build Next: A Practical Guide to WSJF"
description: "Most teams have more ideas than capacity. WSJF is a simple way to figure out which ones to do first."
pubDate: 2025-01-15
updatedDate: 2025-03-10
tags: ["Prioritization", "Product Management"]
readingTime: "12 min read"
---
```

External post (link-only, no local content):

```yaml
---
title: "My Guest Post on Another Blog"
description: "A post I wrote for SomePublication."
pubDate: 2025-06-01
tags: ["Writing"]
external: "https://somepublication.com/my-guest-post"
---
```

---

## 4. Composition Patterns

### Wrapping prose in `<div class="prose-content">`

The `.prose-content` class (from `src/styles/blog-components.css`) applies:
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

Only `ChartContainer` needs `client:load`. All other components are static Svelte that renders at build time — no JavaScript ships to the browser for them. Do **not** add `client:load` to static components; it would add unnecessary JS to the page bundle.

```mdx
<!-- Correct: client:load on ChartContainer only -->
<ChartContainer client:load id="chart1" chartConfig={{...}} />

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
  <ProjectCard letter="C" title="..." description="..." metrics={[...]} jobSize="..." wsjfScore={10.0} />
</div>

<DataTable
  headers={["Project", "Cost of Delay", "Job Size", "WSJF"]}
  rows={[
    ["A: ...", "$17,000/mo", "1,200 hrs", "14.2"],
    ["B: ...", "$30,000/mo", "800 hrs", "37.5"],
    ["C: ...", "$4,000/mo", "400 hrs", "10.0"]
  ]}
  highlightRow={1}
/>
```

---

## 5. Creating New Components

### Location

Place new blog components in `src/components/blog/`. The naming convention is `PascalCase.svelte`.

### Svelte 5 Runes

This project uses Svelte 5. All components **must** use the runes API. Do not use Svelte 4 patterns (`export let`, `$:`, `<slot>`).

| Concept | Svelte 5 Syntax |
|---------|-----------------|
| Props | `let { foo, bar = 'default' }: Props = $props();` |
| Reactive state | `let count = $state(0);` |
| Derived values | `let doubled = $derived(count * 2);` |
| Side effects | `$effect(() => { /* runs when deps change */ });` |
| Slotted content | `children: import('svelte').Snippet` prop + `{@render children()}` |

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

### Guidelines

- Use `<script lang="ts">` for TypeScript in script blocks.
- Prefer **scoped styles** (the `<style>` block at the bottom of the `.svelte` file). They are automatically scoped to the component.
- If a component is purely presentational (no browser interactivity), it does not need `client:load` in MDX — Astro renders it at build time.
- If a component needs browser APIs (`window`, `document`, `$effect` with DOM access), it needs `client:load` when used in MDX.

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

Common patterns used in blog posts:

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

---

## Quick Reference: All Imports

Copy this block into a new MDX file and delete the components you do not need:

```mdx
import Callout from '../../components/blog/Callout.svelte';
import TldrBox from '../../components/blog/TldrBox.svelte';
import SectionHeading from '../../components/blog/SectionHeading.svelte';
import FormulaBox from '../../components/blog/FormulaBox.svelte';
import ExampleCard from '../../components/blog/ExampleCard.svelte';
import ProjectCard from '../../components/blog/ProjectCard.svelte';
import PitfallCard from '../../components/blog/PitfallCard.svelte';
import StepList from '../../components/blog/StepList.svelte';
import StepItem from '../../components/blog/StepItem.svelte';
import DataTable from '../../components/blog/DataTable.svelte';
import MetricBar from '../../components/blog/MetricBar.svelte';
import ChartContainer from '../../components/blog/ChartContainer.svelte';
import LinkCard from '../../components/blog/LinkCard.svelte';
```
