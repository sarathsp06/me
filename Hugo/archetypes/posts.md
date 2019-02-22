+++
title = "{{ replace .Name "-" " " | title }}"
tags = [
    "go",
    "golang",
    "templates",
    "themes",
    "development",
]
date = "2019-01-02"
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