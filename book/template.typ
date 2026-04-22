// ==========================================================================
// Astro + Svelte Tutorial — Typst Template
// Reusable styles, functions, and layout for the tutorial book.
// ==========================================================================

// ---------------------------------------------------------------------------
// Colors
// ---------------------------------------------------------------------------
#let primary       = rgb("#1a1a2e")
#let astro-purple  = rgb("#7c3aed")
#let svelte-orange = rgb("#ff3e00")
#let accent        = astro-purple
#let code-bg       = rgb("#f8f9fa")
#let code-border   = rgb("#dee2e6")
#let blue          = rgb("#2563eb")
#let gray-600      = rgb("#4b5563")
#let gray-400      = rgb("#9ca3af")
#let green         = rgb("#059669")
#let warn-orange   = rgb("#d97706")
#let dark-bg       = rgb("#0f172a")
#let slate-700     = rgb("#334155")
#let table-header-bg = rgb("#f3f4f6")

// Cover-specific shades
#let cover-mid    = rgb("#a78bfa")
#let cover-light  = rgb("#c4b5fd")
#let cover-rule   = rgb("#cccccc")
#let cover-title  = rgb("#333333")
#let cover-sub    = rgb("#555555")
#let cover-body   = rgb("#666666")
#let cover-meta   = rgb("#888888")
#let cover-series = rgb("#666666")

// ---------------------------------------------------------------------------
// Reusable Components
// ---------------------------------------------------------------------------

/// Chapter header block: tag + title.
#let chapter-header(number, title) = {
  if number != "" {
    text(
      font: "Inter", weight: "bold", size: 11pt,
      fill: accent,
    )[CHAPTER #number]
    v(2pt)
  }
  heading(level: 1, title)
}

/// Section heading (level 2).
#let section-head(title) = heading(level: 2, title)

/// File reference — italic blue text.
#let file-ref(ref-text) = {
  v(4pt)
  text(font: "Inter", style: "italic", size: 9pt, fill: blue)[File: #ref-text]
  v(2pt)
}

/// Code block wrapper.
#let code-block(code-text, lang: none) = {
  code-text
}

/// File reference immediately followed by a code block, kept together.
#let file-code(ref-text, code-text) = {
  block(breakable: false)[
    #file-ref(ref-text)
    #code-block(code-text)
  ]
}

/// Body paragraph (justified Inter).
#let body-text(content) = {
  text(font: "Inter", size: 10.5pt, content)
}

/// Bullet item.
#let bullet-item(content) = {
  list.item(content)
}

/// Gotcha box — warning-colored heading + gray body, kept together.
#let gotcha(number, title, body) = {
  block(breakable: false, above: 10pt, below: 6pt)[
    #text(
      font: "Inter", weight: "bold", size: 10.5pt,
      fill: warn-orange,
    )[Gotcha #number: #title]
    #v(2pt)
    #text(font: "Inter", size: 10pt, fill: gray-600, body)
  ]
}

/// Key concept box — purple accent.
#let key-concept(title, body) = {
  block(breakable: false, above: 10pt, below: 6pt)[
    #text(
      font: "Inter", weight: "bold", size: 10.5pt,
      fill: astro-purple,
    )[#title]
    #v(2pt)
    #text(font: "Inter", size: 10pt, fill: gray-600, body)
  ]
}

/// Horizontal rule.
#let hr() = line(length: 100%, stroke: 0.5pt + code-border)

/// Styled link / URL text.
#let link-text(body) = text(fill: blue, body)

// ---------------------------------------------------------------------------
// Reference Table Helpers
// ---------------------------------------------------------------------------

#let th(body) = {
  table.cell(fill: table-header-bg, text(weight: "bold", fill: primary, size: 9pt, body))
}

#let tc(body) = {
  text(font: "Fira Code", size: 8.5pt, body)
}

#let td(body) = {
  text(size: 9pt, body)
}

#let tb(body) = {
  text(weight: "bold", size: 9pt, body)
}

#let ref-table(columns: (), ..cells) = {
  table(
    columns: columns,
    align: (left,) * columns.len(),
    stroke: 0.5pt + code-border,
    inset: 6pt,
    ..cells,
  )
}

// ---------------------------------------------------------------------------
// Cover Page
// ---------------------------------------------------------------------------

#let cover-page(
  title: "Astro + Svelte",
  subtitle: "Islands All The Way Down",
  tagline: none,
  series: "PERSONAL ENGINEERING SERIES",
  topics: "Astro · Svelte 5 · MDX · Content Collections",
  meta: none,
  publisher: "ABLATION",
  version: "v0.0.0",
) = {
  page(
    margin: 0pt,
    footer: none,
  )[
    #set text(font: "Inter")

    // White background
    #place(top + left, rect(width: 100%, height: 100%, fill: white))

    // Top colored band
    #place(top + left, rect(width: 100%, height: 12pt, fill: astro-purple))

    // Series branding
    #place(top + left, dx: 48pt, dy: 36pt)[
      #text(fill: cover-series, size: 9pt, weight: "bold", tracking: 1pt)[#series]
    ]

    // Rule below branding
    #place(top + left, dx: 48pt, dy: 56pt,
      rect(width: 516pt, height: 0.5pt, fill: cover-rule),
    )

    // ── Illustration: islands rising from water ──
    #place(top + left, dx: 80pt, dy: 100pt)[
      #box(width: 460pt, height: 280pt)[
        // Water line
        #place(left + bottom, dy: -60pt,
          rect(width: 460pt, height: 0.5pt, fill: rgb("#93c5fd")))

        // Islands (solid blocks = interactive components)
        #place(left + bottom, dx: 20pt, dy: -70pt,
          rect(width: 50pt, height: 45pt, fill: astro-purple, radius: 3pt))
        #place(left + bottom, dx: 100pt, dy: -68pt,
          rect(width: 35pt, height: 30pt, fill: svelte-orange, radius: 3pt))
        #place(left + bottom, dx: 180pt, dy: -75pt,
          rect(width: 60pt, height: 55pt, fill: astro-purple, radius: 3pt))
        #place(left + bottom, dx: 280pt, dy: -65pt,
          rect(width: 40pt, height: 25pt, fill: svelte-orange, radius: 3pt))
        #place(left + bottom, dx: 360pt, dy: -72pt,
          rect(width: 55pt, height: 42pt, fill: astro-purple, radius: 3pt))

        // Static HTML sea (fading blocks below waterline)
        #place(left + bottom, dx: 10pt, dy: -30pt,
          rect(width: 440pt, height: 18pt, fill: rgb(124, 58, 237, 30), radius: 2pt))
        #place(left + bottom, dx: 30pt, dy: -8pt,
          rect(width: 400pt, height: 14pt, fill: rgb(124, 58, 237, 15), radius: 2pt))

        // Labels
        #place(left + bottom, dx: 25pt, dy: -120pt,
          text(fill: astro-purple, size: 7pt, weight: "bold", tracking: 0.5pt)[INTERACTIVE])
        #place(left + bottom, dx: 105pt, dy: -102pt,
          text(fill: svelte-orange, size: 7pt, weight: "bold", tracking: 0.5pt)[SVELTE])
        #place(left + bottom, dx: 190pt, dy: -135pt,
          text(fill: astro-purple, size: 7pt, weight: "bold", tracking: 0.5pt)[ISLAND])
        #place(left + bottom, dx: 140pt, dy: 8pt,
          text(fill: rgb("#93c5fd"), size: 7pt, weight: "bold", tracking: 0.5pt)[STATIC HTML])
      ]
    ]

    // Title
    #place(top + left, dx: 48pt, dy: 420pt)[
      #text(fill: cover-title, size: 48pt, weight: "bold")[#title]
    ]

    // Subtitle
    #place(top + left, dx: 48pt, dy: 482pt)[
      #text(fill: cover-sub, size: 22pt, style: "italic")[#subtitle]
    ]

    // Tagline
    #if tagline != none {
      place(top + left, dx: 48pt, dy: 524pt)[
        #box(width: 420pt)[
          #text(fill: cover-body, size: 12pt)[#tagline]
        ]
      ]
    }

    // Bottom separator band
    #place(bottom + left, dy: -120pt,
      rect(width: 100%, height: 4pt, fill: astro-purple),
    )

    // Topics
    #place(bottom + left, dx: 48pt, dy: -70pt)[
      #text(fill: astro-purple, size: 11pt, weight: "bold")[#topics]
    ]

    // Meta info
    #if meta != none {
      place(bottom + left, dx: 48pt, dy: -46pt)[
        #text(fill: cover-meta, size: 9pt)[#meta]
      ]
    }

    // Publisher badge
    #place(bottom + right, dx: -48pt, dy: -50pt)[
      #box(
        stroke: 1.5pt + astro-purple,
        radius: 2pt,
        inset: (x: 10pt, y: 6pt),
      )[
        #text(fill: astro-purple, size: 9pt, weight: "bold", tracking: 0.5pt)[#publisher]
      ]
    ]

    // Bottom band
    #place(bottom + left, rect(width: 100%, height: 12pt, fill: astro-purple))
  ]
}

// ---------------------------------------------------------------------------
// Document Setup Function
// ---------------------------------------------------------------------------
#let tutorial-doc(
  title: "Astro + Svelte Tutorial",
  author: "Absolute Ablation",
  version: "v0.0.0",
  body,
) = {
  set page(
    paper: "us-letter",
    margin: (top: 0.6in, bottom: 0.6in, left: 0.75in, right: 0.75in),
    footer: context {
      if counter(page).get().first() > 1 {
        set text(font: "Inter", size: 8pt, fill: gray-400)
        grid(
          columns: (1fr, 1fr, 1fr),
          align: (left, center, right),
          [Astro + Svelte Tutorial],
          [#counter(page).display()],
          [Absolute Ablation],
        )
      }
    },
  )

  counter(page).update(1)

  set text(font: "Inter", size: 10.5pt, fill: black)
  set par(justify: true, leading: 0.65em)

  show heading.where(level: 1): it => {
    set text(font: "Inter", weight: "bold", size: 22pt, fill: primary)
    block(above: 0pt, below: 12pt, it.body)
  }

  show heading.where(level: 2): it => {
    set text(font: "Inter", weight: "bold", size: 14pt, fill: primary)
    block(above: 16pt, below: 6pt, breakable: false, it.body)
  }

  set list(marker: [•], indent: 6pt, body-indent: 8pt, spacing: 6pt)

  show raw.where(block: false): it => {
    box(
      text(font: "Fira Code", size: 9.5pt, it),
    )
  }

  show raw.where(block: true): it => {
    block(
      width: 100%,
      fill: code-bg,
      stroke: 0.5pt + code-border,
      inset: 8pt,
      radius: 2pt,
      below: 8pt,
      text(font: "Fira Code", size: 9pt, it),
    )
  }

  set document(title: title, author: author)

  body
}
