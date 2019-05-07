+++
title = "Gojson : A Simple JSON Parser"
date = 2019-04-30T14:10:10+01:00
toc = true
+++


GoJSON is a command line utility to handle JSON serialised data. You can find the code [here](https://github.com/sarathsp06/gojson)

### What it does

- [x] Pretty print JSON
- [x] Retrieve nested objects
- [x] Validate JSON
- [x] Aggregate functions


## Installing

**Go Dev version**

```sh
$ go get -u github.com/sarathsp06/gojson
```


**Binray Release**

[download](https://github.com/sarathsp06/gojson/releases) and use the binary as such for your platform


**Tip:** In unix move the binary to PATH


#### Key Syntax

* Key is a set of **_._** separated nested values
* Can use 0-n numbers to refer to index in arrays
* Can use **lower:upper** syntax to refer to a range of an array
* Can use keys of inner objects directly on arrays or range of them. Eg:  players.name where players is an array


### Usage Examples

##### Getting a value

* Get a string:

```sh
$ echo '{"name":{"first":"Sarath","last":"Pillai"}}' | gojson name.last
"Pillai"
```

* Get a block of JSON:

```sh
$ echo '{"name":{"first":"Sarath","last":"Pillai"}}'  | gojson name

{
  "first": "Sarath",
  "last": "Pillai"
}
```

* Try to get a non-existent key:

```sh
$ echo '{"name":{"first":"Sarath","last":"Pillai"}}' | gojson names
nil

```

* Get an array value by index:

```sh
$ echo '{"people":[{"name":"saratha"},{"name":"syam"}]}' | gojson people.1.name                                               
"syam"
```

* Projection from a slice

```sh
$ echo '{"people":[{"name":"saratha"},{"name":"syam"},{"name":"singh"},{"name":"ping"}]}' | gojson people.2:.name
[
  "singh",
  "ping"
]
```

* Slice of array

```sh
$ echo '{"people":[{"name":"saratha"},{"name":"syam"},{"name":"singh"},{"name":"ping"}]}' | gojson people.2:5    
[
  {
    "name": "singh"
  },
  {
    "name": "ping"
  }
]
```


[![Build Status](https://travis-ci.org/sarathsp06/gojson.svg?branch=master)](https://travis-ci.org/sarathsp06/gojson)
