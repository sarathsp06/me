// ==========================================================================
// CV — Sarath Sadasivan Pillai
// Typst source — compile with: make cv
// ==========================================================================

// ---------------------------------------------------------------------------
// Page setup
// ---------------------------------------------------------------------------
#let ink = luma(20)
#let muted = luma(95)
#let faint = luma(140)

#set page(paper: "a4", margin: (x: 18mm, top: 14mm, bottom: 13mm))
#let body-font = sys.inputs.at("font", default: "Charter")
#set text(font: (body-font, "Inter"), size: 9pt, fill: ink, lang: "en", hyphenate: false)
#set par(justify: false, leading: 0.62em, spacing: 0.9em)
#set list(marker: text(fill: faint)[–], indent: 0pt, body-indent: 6pt, spacing: 0.55em)
#show link: it => it

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------
#let section(title) = {
  v(10pt)
  text(size: 7.5pt, weight: "semibold", tracking: 1.4pt, fill: muted)[#upper(title)]
  v(-5pt)
  line(length: 100%, stroke: 0.4pt + luma(200))
  v(3pt)
}

#let role(title, company, place, dates) = block(sticky: true, above: 12pt, below: 5pt, {
  grid(
    columns: (1fr, auto),
    align: (left + bottom, right + bottom),
    [#text(weight: "semibold")[#title]#h(4pt)#text(fill: muted)[· #company]],
    text(size: 8pt, fill: muted)[#dates],
  )
  v(-4pt)
  text(size: 8pt, fill: faint)[#place]
})

#let stack(..items) = {
  v(-1pt)
  text(size: 7.5pt, fill: faint)[#items.pos().join(", ")]
}

#let sep = h(5pt) + text(fill: faint)[·] + h(5pt)

// ---------------------------------------------------------------------------
// Header
// ---------------------------------------------------------------------------
#text(size: 20pt, weight: "semibold", tracking: -0.3pt)[Sarath Sadasivan Pillai]
#v(-6pt)
#text(size: 10.5pt, fill: muted)[Engineering Director · Tech Lead · Distributed Systems]
#v(1pt)
#text(size: 8pt, fill: muted)[
  Rotterdam, NL (hybrid / EU remote) #sep
  #link("mailto:sarath.sp06@gmail.com")[sarath.sp06\@gmail.com] #sep
  +31 6 57358212 \
  #link("https://sarathsadasivan.com")[sarathsadasivan.com] #sep
  #link("https://github.com/sarathsp06")[github.com/sarathsp06] #sep
  #link("https://linkedin.com/in/sarathsp")[linkedin.com/in/sarathsp]
]

// ---------------------------------------------------------------------------
// Profile
// ---------------------------------------------------------------------------
#section("Profile")

Engineering leader and hands-on tech lead with 12+ years designing and running distributed backend systems in Go. Today I am Director of Engineering at WellSync, a medtech company, where I lead the team and its technical direction on services that handle sensitive health data, and co-founder and CTO of Message+.

Earlier I drove Exotel's platform-wide migration from PHP/Ruby/Java to Go and led its API team on a 99.999% SLA platform, then built real-time voice infrastructure at MessageBird, a live-streaming backend at Onefootball, and compliance-critical data systems at Shell. I work at staff level: shaping architecture across teams, setting engineering standards, mentoring engineers, and turning reliability goals (delivery guarantees, observability, API design) into decisions that business, legal, and regulatory stakeholders can follow.

// ---------------------------------------------------------------------------
// Skills
// ---------------------------------------------------------------------------
#section("Skills")

#grid(
  columns: (22mm, 1fr),
  column-gutter: 8pt,
  row-gutter: 0.75em,
  text(fill: muted)[Languages], [Go (primary, \~10 years), Python, SQL, JavaScript/Svelte, Java, PHP],
  text(fill: muted)[Systems], [Distributed systems, event-driven architecture, REST and gRPC API design, webhooks, delivery guarantees and retries, high-throughput real-time services],
  text(fill: muted)[Reliability], [Observability, monitoring and logging (Grafana, OpenTelemetry), incident review, SLAs, error budgets],
  text(fill: muted)[Data & tools], [PostgreSQL, MySQL, Linux, gRPC, SvelteKit, Claude Code (agentic development)],
  text(fill: muted)[Domains], [Cloud communications / CPaaS (voice, SMS, messaging), real-time media, medtech and health data, regulated systems (GDPR, telecom, audit)],
  text(fill: muted)[Leadership], [Technical direction, mentoring, coding standards and review, working with product, business, and legal stakeholders],
)

// ---------------------------------------------------------------------------
// Experience
// ---------------------------------------------------------------------------
#section("Experience")

#role("Director of Engineering · Tech Lead", "WellSync", "Rotterdam / Barendrecht, NL — medtech", "Aug 2024 – Present")
- Led development of new revenue-generating services with strong reliability guarantees.
- Improved system observability so production behaviour is easier to detect, investigate, and document.
- Mentored engineers on development and release practices, reducing production problems.
- Improved infrastructure and technical support capabilities.
- Brought Sparrow, my own webhook delivery system, into production use.
#stack("Go", "Kubernetes", "PostgreSQL", "gRPC", "Kafka", "Grafana", "Azure")

#role("Co-Founder & CTO", "Message+", "Rotterdam, NL — remote, part-time — multi-channel customer support", "Dec 2022 – Present")
- Co-founded the company and own its technical direction.
- Sole backend developer: built the Go backend, including the AI-assisted support component.
- Designed scalable enterprise messaging infrastructure; launched on WhatsApp first, then Instagram.
- Built support-metric tracking (response time, resolution rate).
- Work directly with customers on integration, contracts, and compliance expectations.
#stack("Go", "PostgreSQL", "gRPC", "REST", "New Relic", "Azure")

#role("Senior Software Engineer", "Shell", "Rotterdam, NL", "Nov 2020 – Aug 2024")
- Built and maintained data-driven systems for sustainability and regulatory reporting, where data quality and timeliness were compliance-critical.
- Worked with business stakeholders on product strategy, internal controls, and audit expectations.
- Designed systems to be easy to monitor, explain, and adjust as regulation changed.
#stack("Go", "Kubernetes", "PostgreSQL", "gRPC", "Kafka", "New Relic", "Azure")

#role("Senior Software Engineer", "MessageBird (Bird)", "Amsterdam, NL", "Jun 2019 – Nov 2020")
- Built core real-time call-handling logic in Go: call setup, connection, and completion.
- Kept voice services stable against strict service-level and contractual requirements; improved API availability.
- Introduced clearer monitoring and incident review, reducing downtime. Established shared coding and review practices.
- Worked within telecom regulation, data protection, and cross-border constraints.
#stack("Go", "PHP", "Kubernetes", "MySQL", "Redis", "GCP Pub/Sub", "Elasticsearch", "GCP")

#role("Software Engineer", "Onefootball", "Berlin, DE", "Feb 2019 – Jun 2019")
- Built the backend for OTT video delivery in the mobile apps, enabling live pay-per-view match streaming under hard latency constraints.
#stack("Go", "Kubernetes", "MySQL", "Java", "REST", "GCP")

#role("Technical Lead", "Exotel", "Bengaluru, IN", "May 2014 – Dec 2018")
- Joined as roughly employee 18; the company scaled to \~200 and became Asia's largest cloud telephony platform.
- Led the migration of the full platform from PHP/Ruby/Java to Go — smaller memory footprint, single-binary deployment, and quick for the team to learn.
- Owned the usage-based billing system: ran the Java version, then rewrote it in Go.
- Led the API team and guided public API and SDK design on a 99.999% SLA platform.
- Led teams scaling core calling and messaging systems for high-volume customers, and delivered Exotel's first mobile app on a short timeline.
#stack("Go", "PHP", "Kubernetes", "MySQL", "Aerospike", "Beanstalk", "Elasticsearch", "AWS")

// ---------------------------------------------------------------------------
// Projects
// ---------------------------------------------------------------------------
#section("Independent Projects")

#text(weight: "semibold")[Sparrow] #h(3pt) #text(size: 8pt, fill: faint)[Go, PostgreSQL, gRPC, SvelteKit] \
Event-driven webhook delivery with at-least-once guarantees, backoff retries, `Retry-After` handling, idempotency keys, and full observability. In production at WellSync.

#text(weight: "semibold")[TestHooks] #h(3pt) #text(size: 8pt, fill: faint)[Go, Svelte · open source] \
A self-hostable webhook.site replacement: capture, inspect, transform, and forward webhooks in real time from a single binary.

#text(weight: "semibold")[JanusFS] #h(3pt) #text(size: 8pt, fill: faint)[Go, FUSE, Linux · open source] \
Secret-masking filesystem for AI agents: secrets read as `****` with byte length preserved, kernel-enforced on Linux. #link("https://github.com/sarathsp06/janusfs")[github.com/sarathsp06/janusfs]

#text(weight: "semibold")[Herdr Web] #h(3pt) #text(size: 8pt, fill: faint)[Go, SvelteKit, WebSocket · open source] \
Mobile-first web inbox for the Herdr agent multiplexer, with live terminals and push alerts; one Go binary, with outside contributors. #link("https://github.com/sarathsp06/herdrweb")[github.com/sarathsp06/herdrweb]

// ---------------------------------------------------------------------------
// Education & Languages
// ---------------------------------------------------------------------------
#section("Education & Languages")

#grid(
  columns: (1fr, auto),
  [#text(weight: "semibold")[B.Tech, Computer Science & Engineering] #h(3pt) #text(fill: muted)[· TKM College of Engineering · CGPA 8.24/10]],
  text(size: 8pt, fill: muted)[2009 – 2013],
)

#v(4pt)
English (full professional) #sep Malayalam (native) #sep Hindi (limited working)
// ---------------------------------------------------------------------------
// Highlights
// ---------------------------------------------------------------------------
#section("Highlights")

- Led the migration of Exotel's entire platform from PHP, Ruby, and Java to Go. Joined as roughly employee 18; the company scaled to \~200.
- Led Exotel's API team on an API-first platform run under a 99.999% SLA. API customers at Exotel and MessageBird included Google and Uber.
- Built Message+ single-handedly as CTO and sole backend developer.
- Author of Sparrow, an event-driven webhook delivery system now in production at WellSync.

