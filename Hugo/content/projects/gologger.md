+++
title = "Gologger"
date = 2019-02-24T08:56:53+01:00
toc = true
+++




![Logo of the project](http://www.davesgames.net/papercraft/png/gallery-logs-01.png)


#### Logger library for the gophers

An opinionated logging library for golang. Gologger writes logs as json in the following format

```json
{
    "time":"2016-11-10T16:11:46.59Z",
    "process_name":"sample_logger",
    "host_name":"sarath.local",
    "process_id":29422,
    "level":"ERROR",
    "file_name":"/home/sarath/go/src/github.com/sarathsp06/gologger/sample/main.go",
    "line_num":13,
    "log_msg":"error happened"
}
```  

That much info will be how following will be written
```golang
logger.Error("error happened")
```

## Installing / Getting started

Just like any other go library

{{< highlight sh>}}
go get github.com/sarathsp06/gologger
{{< / highlight >}}

But if one needs to get a particular version then use

{{< highlight sh>}}
go get gopkg.in/sarathsp06/gologger.vx #x is the version Number
{{< / highlight >}}


## Developing

Here's a brief intro about what a developer must do in order to start developing
the project further:

1. Get it using go get or clone
2. Make changes and make a pull request with Updated README if feature addition


## Features

What's all the bells and whistles this project can perform?
* It can log - Obviously
* Easy buffered logging
* You can set write to logger for redirecting logs
* log message will contain much deeper details like line number of error , process id,host_name  etc


## How to use
This is how one may use the library

import the package

{{< highlight go>}}
import logger "github.com/sarathsp06/gologger"
{{< / highlight >}}
Initialize the  package

{{< highlight go>}}
if err := logger.InitLogger("INFO", ".", "sample_logger",true); err != nil {
		panic(err.Error())
}
{{< / highlight >}}

Log as you wish with formated and normal message

{{< highlight go>}}
logger.Error("error happened")
logger.Debug("Debug message",":Sasa","sasa")
logger.Info("error happened")
logger.Warning("error happened")
logger.Errorf("error happened %s", "Yo")
logger.Debugf("debug message : %s", "YoYo")
{{< / highlight >}}

Explore more ....


Here is a sample code

{{< highlight go "linenos=table">}}
package main

import (
	"os"
	logger "github.com/sarathsp06/gologger"
)

func main() {
	if err := logger.InitLogger("INFO", ".", "sample_logger",true); err != nil {
		panic(err.Error())
	}
	logger.SetLogWriter(os.Stdout)
	logger.Error("error happened")
	logger.Debug("Debug message")
	logger.Info("error happened")
	logger.Warning("error happened")
	logger.Errorf("error happened %s", "Yo")
	logger.Debugf("debug message : %s", "YoYo")
}
{{< / highlight>}}

## Licensing

The code in this project is licensed under MIT license.
