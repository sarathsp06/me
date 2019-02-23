+++
title = "{{ replace .Name "-" " " | title }}"
tags = [
    "go",
    "golang",
    "templates",
    "themes",
    "development",
]
date = {{.Date}}
toc = true
+++

```
title: {{ printf "%#v" . }}
date: {{ .Date }}
draft: true
toc: true
images:
tags: 
  - untagged
 ```