+++
title= "Exotel Py"
toc= true
date= 2019-02-22T01:09:41+01:00
+++

Python module for Exotel's call and sms APIs.   [exotel-py](https://github.com/sarathsp06/exotel-py)

### Installation ###

```sh
pip install exotel
```

### Usage ###

- Initialize

```py
from exotel import Exotel
client = Exotel(sid,token)
```

- make call to connect a number to another

```py
client.call_number('from_number','exophone','to_number')
```

- make call to connect a number to a flow

```py
client.call_flow('from_number','exophone','flow_id')
```

- send an sms

```py
client.sms('from_number',to_number',"sms_body")
```

- get details of an sms

```py
client.sms_details('sms_sid')
```

- get details of a call

```py
client.call_details('call_sid')
```


### Authors and Contributors ###

In 2015, Sarath S Pillai ([@sarath_sp06](https://twitter.com/sarath_sp06)) started. It is *not* actively maintained now so issues might be responded with some delay but feel free to report issues and make PR


### Stargazers over time

[![Stargazers over time](https://starcharts.herokuapp.com/sarathsp06/exotel-py.svg)](https://starcharts.herokuapp.com/sarathsp06/exotel-py)

### Support or Contact ###
Having trouble using the library contact me at sarath.sp06@gmail.com or open a new issue [here](https://github.com/sarathsp06/exotel-py/issues/new)
