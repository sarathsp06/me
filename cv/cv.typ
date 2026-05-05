// ==========================================================================
// CV — Sarath Sadasivan Pillai
// Typst source — compile with: make cv
// ==========================================================================

// ---------------------------------------------------------------------------
// Page setup
// ---------------------------------------------------------------------------
#set page(paper: "a4", margin: (x: 0.5in, top: 0.35in, bottom: 0.35in))
#set text(font: "Fira Code", size: 8pt, fill: black)
#set par(justify: true, leading: 0.5em)
#set list(marker: [•], indent: 4pt, body-indent: 5pt, spacing: 2pt)

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------
#let section-title(title) = {
  v(5pt)
  text(size: 9.5pt, weight: "bold")[#title]
  v(1pt)
  line(length: 100%, stroke: 0.75pt + black)
  v(2pt)
}

#let role-header(title, dates, company) = {
  grid(
    columns: (1fr, auto),
    text(weight: "bold", size: 8pt)[#title],
    text(size: 7.5pt, fill: luma(100))[#dates],
  )
  text(size: 8pt, fill: luma(80))[#company]
  v(1pt)
}

#let tech-stack(..items) = {
  text(size: 7pt, fill: luma(100))[#items.pos().join("  ·  ")]
}

// ---------------------------------------------------------------------------
// Header
// ---------------------------------------------------------------------------
#align(center)[
  #text(size: 16pt, weight: "bold")[Sarath Sadasivan Pillai]
  #v(2pt)
  #text(size: 8.5pt, fill: luma(60))[Backend Systems Engineer · Engineering Leader]
  #v(2pt)
  #text(size: 7.5pt, fill: luma(80))[
    Specializing in *Go* · *Distributed Systems* · *Linux* · *PostgreSQL*
  ]
  #v(3pt)
  #text(size: 7pt, fill: luma(100))[
    #link("mailto:sarath.sp06@gmail.com")[sarath.sp06\@gmail.com] #h(6pt) | #h(6pt)
    +31 6 57358212 #h(6pt) | #h(6pt)
    Rotterdam, NL #h(6pt) | #h(6pt)
    #link("https://sarathsadasivan.com")[sarathsadasivan.com] #h(6pt) | #h(6pt)
    #link("https://github.com/sarathsp06")[github.com/sarathsp06] #h(6pt) | #h(6pt)
    #link("https://linkedin.com/in/sarathsp")[linkedin.com/in/sarathsp]
  ]
]

#v(1pt)

// ---------------------------------------------------------------------------
// Profile
// ---------------------------------------------------------------------------
#section-title("Profile")

I build reliable, scalable backend systems. 11+ years deep in Go, distributed systems, and infrastructure. Currently Director of Engineering at WellSync and co-founding a product company — I enjoy the overlap of engineering depth and product thinking.

// ---------------------------------------------------------------------------
// Technical Skills
// ---------------------------------------------------------------------------
#section-title("Skills")

#text(size: 7.5pt)[
  *Languages:* Go, Python, JavaScript #h(1fr)
  *Infrastructure:* Kubernetes, Azure, GCP, AWS, Kafka, Redis \
  *Data:* PostgreSQL, MySQL, Aerospike, Elastic Search #h(1fr)
  *Practices:* Distributed Systems, REST/gRPC, Observability, Leadership
]

// ---------------------------------------------------------------------------
// Professional Experience
// ---------------------------------------------------------------------------
#section-title("Experience")

#role-header("Director of Engineering", "Aug 2024 – Present", "WellSync")
- Lead *technical architecture* and development of scalable *healthcare technology* solutions
- Drive *system performance optimization* and infrastructure improvements across all services
- *Mentor engineering teams* and establish best practices for distributed system development
#tech-stack("Go", "K8s", "PostgreSQL", "gRPC", "Kafka", "Grafana", "Azure")

#v(3pt)

#role-header("Co-Founder & CTO", "Dec 2022 – Present", "Message+")
- Co-founded *AI-powered customer support platform* for WhatsApp and Instagram at scale
- Architected *scalable messaging infrastructure* handling personalized support for enterprises
- Built *analytics system* tracking response times, resolution rates, and satisfaction
#tech-stack("Go", "PostgreSQL", "gRPC", "REST", "NewRelic", "Azure")

#v(3pt)

#role-header("Senior Software Engineer", "Nov 2020 – Sep 2024", "Shell")
- Built *data-driven systems* for environmental impact compliance, monitoring, and sustainability
- Delivered *scalable backend services* for environmental data processing across teams
#tech-stack("Go", "K8s", "PostgreSQL", "gRPC", "Kafka", "NewRelic", "Azure")

#v(3pt)

#role-header("Senior Software Engineer", "Jun 2019 – Oct 2020", "MessageBird")
- Designed *fault-tolerant voice platform* and call execution engine for *high-volume traffic*
- *Mentored engineers* and established knowledge sharing practices across departments
#tech-stack("Go", "PHP", "K8s", "MySQL", "Redis", "GCP-PubSub", "Elastic Search", "GCP")

#v(3pt)

#role-header("Software Engineer", "Feb 2019 – Jun 2019", "Onefootball")
- Built *live streaming infrastructure* for football matches on pay-per-view basis
#tech-stack("Go", "K8s", "MySQL", "Java", "REST", "GCP")

#v(3pt)

#role-header("Technical Lead (SDE 3)", "May 2014 – Dec 2018", "Exotel Techcom")
- Led *REST services architecture* for enterprise communications; *scaled from startup to enterprise*
- Progressed from Full Stack Developer to *Technical Lead* across JS, PHP, Ruby, Java, and Go
- Established *engineering culture*, design patterns, and system architecture best practices
#tech-stack("Go", "PHP", "K8s", "MySQL", "Aerospike", "Beanstalk", "Elastic Search", "AWS")

// ---------------------------------------------------------------------------
// Education
// ---------------------------------------------------------------------------
#section-title("Education")

#grid(
  columns: (1fr, auto),
  [*B.Tech in Computer Science & Engineering* — TKM College of Engineering, Kollam],
  text(size: 7.5pt, fill: luma(100))[2009 – 2013],
)
